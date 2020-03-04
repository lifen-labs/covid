class Twilio::HandleSmsStatus

  ERROR_STATUSES = ['failed', 'undelivered'].freeze

  def self.call(status_params)
    new(status_params).call
  end

  def initialize(status_params)
    @status_params = status_params
  end

  attr_reader :status_params

  def call
    Rails.logger.info "[Twilio][SmsStatus] To: #{to} Status: #{status}"

    return unless error_status?

    Slack::ApplicationJob.perform_later(slack_message)
  end

  private

    def status
      status_params['MessageStatus']
    end

    def to
      status_params['To']
    end

    def error_status?
      ERROR_STATUSES.include? status.to_s.downcase
    end

    def slack_message
      {
        attachments: [
          {
            fallback: 'SMS en erreur',
            color: '#d02323',
            author_name: "Covid - #{Rails.env}",
            title: 'SMS en erreur',
            fields: [
              {
                title: 'To',
                value: to,
                short: true
              },
              {
                title: 'Status',
                value: status,
                short: true
              }
            ]
          }
        ]
      }
    end

end