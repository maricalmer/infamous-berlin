ActionMailer::Base.smtp_settings = {
  address: ENV['MAILJET_SMTP_SERVER'],
  port: ENV['MAILJET_PORT'],
  domain: 'infamousberlin.com',
  user_name: ENV['MAILJET_API_KEY'],
  password: ENV['MAILJET_SECRET_KEY'],
  enable_starttls_auto: true,
  authentication: 'plain'
}
