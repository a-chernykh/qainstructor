module JobRunner

  class Container
    IMAGE_NAME = 'qainstructor/test-runner'
    LINKS = 'qainstructor_selenium-server_1:selenium-server'
    NETWORK = 'qainstructor_default'

    def initialize(job:, directory:)
      @job = job
      @directory = directory
      @container = nil
    end

    def start
      begin
        @container = Docker::Container.get(container_name)
      rescue Docker::Error::NotFoundError
        create
        @container = Docker::Container.get(container_name)
      end

      @container.start unless is_running?
      raise "Unable to start container: #{@container.info['State']['Error']}" unless @container.info['State']['Error'].blank?
    end

    def exec(*args)
      @container.exec(*args)
    end

    private

    def container_name
      "qainstructor_test-runner_user_#{@job.user.id}"
    end

    def create
      Docker::Container.create(
                'name' => container_name,
                'Image' => IMAGE_NAME,
                'HostConfig' => {
                  'Binds' => ["#{@directory}:/jobs"],
                  'Links' => [LINKS],
                  'NetworkMode' => NETWORK
                })
    end

    def is_running?
      info = @container.info
      info['State']['Running']
    end
  end

end
