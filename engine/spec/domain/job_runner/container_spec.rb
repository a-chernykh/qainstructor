module JobRunner
  RSpec.describe Container do
    let(:directory) { '/jobs/user' }
    let(:user) { create(:user) }
    let(:job) { create(:job, user: user) }
    let(:container_name) { "qainstructor_test-runner_user_#{job.user.id}" }

    subject { described_class.new(job: job, directory: directory) }

    before { allow(job.user).to receive(:id).and_return(1) }

    describe '#start' do
      context 'when container does not exist', vcr: { cassette_name: 'JobRunner_Container/start/when_does_not_exist' } do
        it 'creates it' do
          expect(Docker::Container).to receive(:create)
            .with('name' => container_name,
                  'Image' => 'qainstructor.com:5043/qainstructor/test-runner:0.0.1',
                  'HostConfig' => {
                    'Binds' => ["#{directory}:/jobs"],
                    'Links' => ['qainstructor_selenium-server_1:selenium-server'],
                    'NetworkMode' => 'qainstructor_default'
                  })
            .and_call_original
          subject.start
        end

        it 'starts it' do
          expect_any_instance_of(Docker::Container).to receive(:start)
            .and_call_original
          subject.start
        end
      end

      context 'when container does exist', vcr: { cassette_name: 'JobRunner_Container/start/when_does_exist' } do
        it 'does not tries to create it' do
          expect(Docker::Container).not_to receive(:create)
          subject.start
        end

        it 'starts it' do
          expect_any_instance_of(Docker::Container).to receive(:start)
            .and_call_original
          subject.start
        end
      end
    end

    describe '#exec' do
      it 'delegates to container', :vcr do
        subject.start
        args = ['/bin/echo', 'hello']
        expect_any_instance_of(Docker::Container).to receive(:exec)
          .with(args)
        subject.exec(args)
      end
    end
  end
end
