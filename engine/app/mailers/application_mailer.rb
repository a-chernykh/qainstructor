class ApplicationMailer < ActionMailer::Base
  default from: 'Andrey from QA Instructor <info@qainstructor.com>', bcc: Rails.application.config.admin_email
end
