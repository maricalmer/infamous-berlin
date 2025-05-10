ActionMailer::Base.smtp_settings = {
  address: "in-v3.mailjet.com",
  port: 587,
  domain: 'herokuapp.com',
  user_name: ENV['MAILJET_API_KEY'],
  password: ENV['MAILJET_SECRET_KEY'],
  enable_starttls_auto: true,
  authentication: 'plain'
}
