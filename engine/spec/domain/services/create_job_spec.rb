module Services

  RSpec.describe CreateJob do
    let(:user) { create(:user) }
    let(:attrs) { attributes_for :job }

    subject { described_class.new(attrs: attrs, user: user) }

    before do
      allow_any_instance_of(JobRunner::Cucumber).to receive(:run).and_return true
      allow(JobStatusUpdater).to receive(:perform_async)
    end

    describe '#call' do
      it 'creates job' do
        expect { subject.call }.to change { user.jobs.count }.by(1)
      end

      it 'returns job' do
        expect(subject.call).to be_an_instance_of(Job)
      end

      context 'when job was persisted' do
        it 'adds job runner to queue' do
          expect(JobWorker).to receive(:perform_async).with(anything).and_call_original
          subject.call
        end
      end
    end
  end

end
