require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Covid
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'Paris'
    config.i18n.default_locale = :fr

    # Assets error -> https://github.com/rails/sprockets/issues/581#issuecomment-486984663
    config.assets.configure do |env|
      env.export_concurrent = false
    end

    # Twilio
    config.twilio_account_id = ENV.fetch('TWILIO_ACCOUNT_ID', 'missing-twilio-account-id')
    config.twilio_auth_token = ENV.fetch('TWILIO_AUTH_TOKEN', 'missing-twilio-auth-token')
    config.twilio_phone_number = ENV.fetch('TWILIO_PHONE_NUMBER', 'missing-twilio-phone-bumber')
  end
end
