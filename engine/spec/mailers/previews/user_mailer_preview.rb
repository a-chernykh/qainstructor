class UserMailerPreview < ActionMailer::Preview
  def offline_registration_confirmation
    registration = OfflineRegistration.create!(name: 'John Doe', email: 'john.doe@example.com', phone: '+1 (111) 111-11-11')
    UserMailer.offline_registration_confirmation(id: registration)
  end
end
