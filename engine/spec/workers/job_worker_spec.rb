RSpec.describe JobWorker do
  let(:job) { create :job }

  describe '#perform' do
    let(:runner) { instance_double 'JobRunner::Cucumber' }

    before do
      allow_any_instance_of(JobRunner::Cucumber).to receive(:run).and_return true
      allow_any_instance_of(JobRunner::Cucumber).to receive(:create_assets)
      allow(JobStatusUpdater).to receive(:perform_async)
    end

    it 'runs job' do
      expect(JobRunner::Cucumber).to receive(:new)
        .with(job)
        .and_call_original
      expect_any_instance_of(JobRunner::Cucumber).to receive(:run)
      described_class.perform_async(job.id)
    end

    it 'updates job status' do
      described_class.perform_async(job.id)
      expect(job.reload.status).to eq 'finished'
    end

    it 'queues update status job', :vcr do
      expect(JobStatusUpdater).to receive(:perform_async).with(job.id).and_call_original
      described_class.perform_async(job.id)
    end

    context 'on success' do
      it 'sets job result to success' do
        described_class.perform_async(job.id)
        expect(job.reload).to be_success
      end

      it 'creates assets' do
        expect_any_instance_of(JobRunner::Cucumber).to receive(:create_assets).and_call_original
        described_class.perform_async(job.id)
      end
    end

    context 'on failure' do
      before do
        allow_any_instance_of(JobRunner::Cucumber).to receive(:run).and_return false
      end

      it 'sets job result to failure' do
        described_class.perform_async(job.id)
        expect(job.reload).to be_failure
      end

      it 'creates assets' do
        expect_any_instance_of(JobRunner::Cucumber).to receive(:create_assets).and_call_original
        described_class.perform_async(job.id)
      end
    end

    context 'when exception is raised' do
      it 'sets job result to failure' do
        allow_any_instance_of(JobRunner::Cucumber).to receive(:run).and_raise 'err'
        described_class.perform_async(job.id) rescue nil
        expect(job.reload).to be_failure
      end

      it 'finishes the job' do
        allow_any_instance_of(JobRunner::Cucumber).to receive(:run).and_raise 'err'
        described_class.perform_async(job.id) rescue nil
        expect(job.reload).to be_finished
      end
    end
  end
end
