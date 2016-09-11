class JobWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(job_id)
    job = Job.find job_id

    job.running!
    runner = JobRunner::Cucumber.new job

    begin
      time = Time.now
      if runner.run
        job.success!
      else
        job.failure!
      end
      Rails.logger.debug "Job run time: #{Time.now - time}"

      time = Time.now
      runner.create_assets
      Rails.logger.debug "Create assets time: #{Time.now - time}"
    rescue Exception => e
      job.failure!
      raise e
    ensure
      job.finished!
      JobStatusUpdater.perform_async(job.id)
    end
  end
end
