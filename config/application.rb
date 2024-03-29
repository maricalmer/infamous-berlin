require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InfamousBerlin
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.load_defaults 6.0
    config.exceptions_app = self.routes
    config.active_record.schema_format = :sql
    config.time_zone = "Berlin"
    config.middleware.use Rack::CrawlerDetect
    # config.autoloader = :classic
    # config.autoload_paths += %W(#{config.root}/lib)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
