require 'sidekiq-scheduler'

Sidekiq.default_worker_options['retry'] = 1

Sidekiq.configure_server do |config|
  config.options[:concurrency] = ENV.fetch('SIDEKIQ_CONCURRENCY', '6').to_i

  config.on(:startup) do
    schedule_file_path = Rails.root.join('config', "scheduler_#{Rails.env.downcase}.yml")

    if File.exist?(schedule_file_path)
      Sidekiq.schedule = YAML.load_file(schedule_file_path)
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end