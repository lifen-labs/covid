require 'rails_helper'

RSpec.describe SendSms, type: :model do

  subject(:service)           { SendSms.new(phone_number) }

  let(:twilio_account_id)     { 'twilio-account-id' }
  let(:twilio_auth_token)     { 'twilio-auth-token' }
  let(:twilio_phone_number)   { '+1230405060' }

  let(:phone_number)          { '+33699990000' }
  let(:twilio_url)            { "https://api.twilio.com/2010-04-01/Accounts/#{twilio_account_id}/Messages.json" }

  let!(:stubbed_request)      { stub_request(:post, twilio_url) }
  let(:message)               { 'sms message' }

  def a_twilio_sms_request_to(phone_number)
    a_request(:post, twilio_url).with(a_twilio_sms_request_body_to(phone_number))
  end

  def a_twilio_sms_request_body_to(phone_number)
    {
      body: {
        'Body' => message,
        'From' => twilio_phone_number,
        'To' => phone_number,
        'StatusCallback' => 'http://localhost:3000/twilio/sms_statuses'
      }
    }
  end

  before(:each) do
    allow(Rails.configuration).to receive(:twilio_account_id).and_return(twilio_account_id)
    allow(Rails.configuration).to receive(:twilio_auth_token).and_return(twilio_auth_token)
    allow(Rails.configuration).to receive(:twilio_phone_number).and_return(twilio_phone_number)
  end

  describe '#call' do
    it 'sends the sms using twilio' do
      service.call(message)

      expect(a_twilio_sms_request_to(phone_number)).to have_been_made.once
    end
  end
end
