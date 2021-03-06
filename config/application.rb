require File.expand_path('../boot', __FILE__)
require File.expand_path('../version', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Askalot
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set error field rendering function.
    config.action_view.field_error_proc = lambda { |html, instance| html }

    # Set exceptions application, allows custom error handling.
    config.exceptions_app = self.routes

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Bratislava'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.default_locale = :sk

    config.i18n.load_path += Dir[Rails.root.join 'config', 'locales', '**', '*.{rb,yml}']

    config.i18n.available_locales = [:en, :sk]
  end
end
