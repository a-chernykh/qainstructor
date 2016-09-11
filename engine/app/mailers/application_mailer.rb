class ApplicationMailer < ActionMailer::Base
  default from: 'info@qainstructor.com', bcc: Rails.application.config.admin_email
end
