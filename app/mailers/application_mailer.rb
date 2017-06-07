class ApplicationMailer < ActionMailer::Base
  default from: (ENV['MAILER_FROM_ADDRESS'] || 'no-reply@openbudgets.eu')
  layout 'mailer'
end
