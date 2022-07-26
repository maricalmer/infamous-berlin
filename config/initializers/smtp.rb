ActionMailer::Base.smtp_settings = {
  address: ENV['MAILGUN_SMTP_SERVER'],
  port: ENV['MAILGUN_SMTP_PORT'],
  domain: 'www.infamousberlin.com',
  user_name: ENV['MAILGUN_SMTP_LOGIN'],
  password: ENV['MAILGUN_SMTP_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
