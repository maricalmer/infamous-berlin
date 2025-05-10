# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'

# Add additional requires below this line. Rails is not loaded until this point!
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# Capybara Configuration
Capybara.server = :puma, { Silent: true }
Capybara.default_max_wait_time = 10
Capybara.default_normalize_ws = true
Capybara.save_path = 'tmp/screenshots'

# Register drivers
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.register_driver :selenium_remote do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: ENV.fetch('SELENIUM_REMOTE_URL', 'http://localhost:4444/wd/hub'),
    options: Selenium::WebDriver::Chrome::Options.new
  )
end

# Configure host for CI environment
if ENV['CI']
  Capybara.server_host = '0.0.0.0'
  Capybara.server_port = 4000
  Capybara.app_host = "http://#{`hostname`.strip&.downcase || 'localhost'}:#{Capybara.server_port}"
end

RSpec.configure do |config|
  # FactoryBot & Database Cleaner
  config.include FactoryBot::Syntax::Methods

  # Use the right driver for system tests
  config.before(:each, type: :system) do
    if ENV['CI']
      driven_by :selenium_remote
      Capybara.current_driver = :selenium_remote
    else
      driven_by :selenium_chrome_headless
    end
  end

  # Screenshots on failure
  config.after(:each, type: :system) do |example|
    if example.exception
      save_screenshot("#{example.full_description.parameterize.underscore}.png")
      save_page
    end
  end

  # Database cleaner
  config.use_transactional_fixtures = true

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Infer spec type from location
  config.infer_spec_type_from_file_location!

  # Include helpers
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include Warden::Test::Helpers
end
