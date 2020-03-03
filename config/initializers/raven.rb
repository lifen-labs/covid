Raven.configure do |config|
  config.dsn = 'https://a473d7897f5847db9bed02b359f522ff:82a39d9523b84e21a3815c16638f56e5@sentry.io/3540641'

  config.async = lambda { |event|
    SentryJob.perform_later(event.to_hash)
  }

  config.environments = %w[ production staging ]

  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
