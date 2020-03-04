class Twilio::SmsStatusesController < Twilio::ApplicationController
  def create
    Twilio::HandleSmsStatus.call(params)

    head :no_content
  end
end
