module Services

  class CreateJob
    include Base

    def initialize(attrs:, user:)
      @attrs = attrs
      @user = user
    end

    def call
      job = @user.jobs.create(@attrs)
      JobWorker.perform_async job.id if job.persisted?
      job
    end
  end

end
