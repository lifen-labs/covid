class SendSms

  include UrlHelper

  def self.call(phone_number, message)
    new(phone_number).call(message)
  end

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def call(message)
    @message = message

    send_sms!
  end

  attr_reader :phone_number, :message

  private

    def send_sms!
      twilio_client.messages.create(sms_params)
    end

    def sms_params
      {
        from: Rails.configuration.twilio_phone_number,
        to: phone_number,
        body: message,
        status_callback: url_helper.twilio_sms_statuses_url
      }
    end

    def twilio_client
      @_twilio_client ||= Twilio::REST::Client.new(Rails.configuration.twilio_account_id, Rails.configuration.twilio_auth_token)
    end

end