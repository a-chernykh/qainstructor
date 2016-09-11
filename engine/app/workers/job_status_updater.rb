require 'net/http'

class JobStatusUpdater
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(job_id)
    job = Job.find job_id

    uri = URI.parse(ENV['INTERNAL_FAYE_URL'])
    # switching to http, otherwise we will get SSL error in development
    uri.scheme = 'http'

    response = Net::HTTP.post_form(URI.parse(uri.to_s), {message: {
      channel: "/jobs/#{job.token}",
      data: { status: job.status }
    }.to_json})
  end
end
