class UserMailer < ApplicationMailer
  def offline_registration_confirmation(id:)
    @registration = OfflineRegistration.find(id)
    mail(to: @registration.email, subject: 'Registration confirmation')
  end
end
