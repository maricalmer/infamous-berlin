require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InfamousBerlin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Generator configuration
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end

    # Application configuration
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.exceptions_app = self.routes
    config.active_record.schema_format = :sql
    config.time_zone = "Berlin"
    
    # Middleware
    config.middleware.use Rack::CrawlerDetect

    # Autoloading configuration
    config.autoload_once_paths += %W(
      #{config.root}/lib
    )

    # Fix for ActionText deprecation warnings
    config.after_initialize do
      require 'action_text/content_helper'
      require 'action_text/tag_helper'
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
