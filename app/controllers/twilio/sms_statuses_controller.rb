class Twilio::SmsStatusesController < Twilio::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Twilio::HandleSmsStatus.call(params)

    head :no_content
  end
end
