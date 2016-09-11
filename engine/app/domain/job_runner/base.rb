module JobRunner

  class Base
    def initialize(job)
      @job = job
      @files = job.files
      @token = job.token
      @meta = job.meta
    end

    def run
      raise ArgumentError, 'Unable to save files' unless @files.map { |f| f['name'] }.all? { |name| safe_file_name?(name) }
      FileUtils.mkdir_p directory
      @files.each { |file| write_to_file file['name'], file['contents'] }

      @container = Container.new(job: @job, directory: user_jobs_directory)
      @container.start
    end

    def create_assets
      Dir[result_path + '/*'].each do |file|
        @job.job_assets.create! file: File.open(file)
      end
    end

    private

    def write_to_file(name, contents)
      File.open(File.join(directory, name), 'w') do |f|
        f.write contents
      end
    end

    def user_jobs_directory
      File.join(ENV['JOBS_DIR'], Rails.env, @job.user.id.to_s).to_s
    end

    def directory
      File.join(user_jobs_directory, @token).to_s
    end

    def safe_file_name?(name)
      name =~ /\A[a-zA-Z0-9_\-\.]+\z/
    end

    def result_path
      File.join directory, 'result'
    end
  end

end
