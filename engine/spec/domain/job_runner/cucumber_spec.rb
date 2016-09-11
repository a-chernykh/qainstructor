module JobRunner

  RSpec.describe Cucumber do
    let(:job) { create(:job, language: 'cucumber') }
    let(:job_path) { File.join(ENV['JOBS_DIR'], 'test', '1', job.token).to_s }

    subject { described_class.new(job) }

    before do
      allow(JobStatusUpdater).to receive(:perform_async)
      allow($selenium).to receive(:with).and_yield(double(get: ['url', 'sess_id']))
      allow(job.user).to receive(:id).and_return(1)
    end

    describe '#run', vcr: { cassette_name: 'JobRunner_Cucumber/run' } do
      it 'runs bin/verify.sh' do
        expect_any_instance_of(Container).to receive(:exec)
          .with(['bin/verify.sh', job.token])
          .and_return([0, 0, 0])
        expect(subject.run).to be_truthy
      end

      context 'when @browser is mentioned in any of step definitions' do
        it 'passes selenium connection variables' do
          FileUtils.mkdir_p job_path
          File.open(File.join(job_path, 'steps.rb'), 'w') do |f|
            f.write '@browser'
          end

          expect_any_instance_of(Container).to receive(:exec)
            .with(['bin/verify.sh', job.token, 'url', 'sess_id'])
            .and_return([0, 0, 0])
          expect(subject.run).to be_truthy
        end
      end
    end
  end

end
