module JobRunner

  RSpec.describe Base do
    let(:file1) { { 'name' => 'scenario.feature', 'contents' => 'scenario' } }
    let(:file2) { { 'name' => 'step_definitions.rb', 'contents' => 'step definitions' } }
    let(:user) { create(:user) }
    let(:job) { create :job, user: user, files: [file1, file2] }
    let(:job_directory) { File.join(ENV['JOBS_DIR'], 'test', user.id.to_s, job.token) }

    subject { described_class.new(job) }

    describe '#run' do
      before { allow_any_instance_of(Container).to receive(:start) }

      it 'creates job directory' do
        subject.run
        expect(Dir.exists?(job_directory)).to be_truthy
      end

      describe 'adds' do
        it 'scenario.feature' do
          subject.run
          file = File.join job_directory, 'scenario.feature'
          expect(File.read(file)).to eq 'scenario'
        end

        it 'step_definitions.rb' do
          subject.run
          file = File.join job_directory, 'step_definitions.rb'
          expect(File.read(file)).to eq 'step definitions'
        end
      end

      describe 'with unsafe file name' do
        let(:file1) { { 'name' => '../../../../scenario.feature', 'contents' => 'scenario' } }

        it 'does not add file' do
          expect(subject).not_to receive(:write_to_file).with file1['name'], anything
          subject.run rescue nil
        end

        it 'will raise an exception' do
          expect { subject.run }.to raise_error(ArgumentError)
        end
      end

      it 'starts container' do
        container = double('Docker::Container')
        expect(Container).to receive(:new)
          .with(job: job, directory: anything)
          .and_return(container)
        expect(container).to receive(:start)
        subject.run
      end
    end

    describe '#create_assets' do
      let(:file1_path) { File.join(job_directory, 'result/output.html') }
      let(:file2_path) { File.join(job_directory, 'result/screenshot-1.png') }

      before do
        FileUtils.mkdir_p File.join(job_directory, 'result')
        File.open(file1_path, 'w') { |f| f.write '123' }
        File.open(file2_path, 'w') { |f| f.write '456' }
        subject.create_assets
      end

      it 'creates output.html' do
        asset = job.job_assets.where(file: 'output.html').first!
        expect(asset.file.read).to eq '123'
      end

      it 'creates screenshot-1.png' do
        asset = job.job_assets.where(file: 'screenshot-1.png').first!
        expect(asset.file.read).to eq '456'
      end
    end
  end

end
