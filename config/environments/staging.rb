require_relative './production'

Rails.application.configure do
  config.log_level = :debug

  # Devise & external links
  config.action_mailer.default_url_options = {host: 'app-staging.surveillance-covid19.fr'}

  # Enable preview mailers
  # Add the ENABLE_MAILER_PREVIEWS to your enviroment to enable.
  if ENV['ENABLE_MAILER_PREVIEWS'].present?
    config.action_mailer.show_previews = true

    # If you're using RSpec make sure to add the link changing where the previews path is.
    config.action_mailer.preview_path ||= defined?(Rails.root) ? "#{Rails.root}/spec/mailers/previews" : nil
  end

  # Webpacker
  config.webpacker.check_yarn_integrity = false
end
