class NewOfflineRegistration
  include Sidekiq::Worker

  def perform(offline_registration_id)
    UserMailer.offline_registration_confirmation(id: offline_registration_id).deliver_now
  end
end
