class Slack::ApplicationJob < ApplicationJob

  queue_as :default

  def perform(args)
    return unless webhook_enabled?

    notifier.post args
  end

  private

    def webhook_enabled?
      slack_hook_url.present?
    end

    def notifier
      @notifier ||= Slack::Notifier.new slack_hook_url
    end

    def slack_hook_url
      Rails.configuration.slack_hook_url
    end

end
