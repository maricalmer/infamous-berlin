# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent accidental production database access
abort("The Rails environment is running in production mode!") if Rails.env.production?
if Rails.configuration.database_configuration[Rails.env]["database"] =~ /production/
  abort("Connected to a production database in #{Rails.env} mode!")
end

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'

# Load support files
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# Maintain test schema
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# Capybara configuration
Capybara.server = :puma, { Silent: true }
Capybara.default_max_wait_time = 10
Capybara.save_path = 'tmp/screenshots'

# Register headless Chrome driver
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless=new')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-site-isolation-trials')
  options.add_argument('--disable-gpu') if Gem.win_platform?
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.javascript_driver = :selenium_chrome_headless

# Configure host for CI environments
if ENV['CI']
  Capybara.server_host = '0.0.0.0'
  Capybara.server_port = 4000
  hostname = `hostname`.strip.downcase.presence || 'localhost'
  Capybara.app_host = "http://#{hostname}:#{Capybara.server_port}"
end

RSpec.configure do |config|
  # FactoryBot
  config.include FactoryBot::Syntax::Methods

  # Database transactional fixtures
  config.use_transactional_fixtures = true

  # Filter Rails backtrace lines
  config.filter_rails_from_backtrace!

  # Infer test type from file location
  config.infer_spec_type_from_file_location!
end
