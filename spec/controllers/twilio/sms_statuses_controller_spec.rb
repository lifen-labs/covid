require 'rails_helper'

RSpec.describe Twilio::SmsStatusesController, type: :request do
  describe 'POST /twilio/sms_statuses' do

    let(:status) { 'sent' }

    let(:params) do
      {
        "SmsSid": "sms-sid",
        "SmsStatus": status,
        "MessageStatus": status,
        "To": "+33651458411",
        "MessageSid": "message-sid",
        "AccountId": "account-id",
        "From": "+33712324567",
        "ApiVersion": "2010-04-01"
      }
    end

    before do
      allow(Slack::ApplicationJob).to receive(:perform_later)
      allow(Rails.logger).to receive(:info)
    end

    it 'does nothing' do
      post '/twilio/sms_statuses', params: params

      expect(response).to have_http_status(204)
      expect(Slack::ApplicationJob).to_not have_received(:perform_later)
      expect(Rails.logger).to have_received(:info).with("[Twilio][SmsStatus] To: +33651458411 Status: sent").once
    end

    context 'failed status' do
      let(:status) { 'failed' }

      it 'alerts slack' do
        post '/twilio/sms_statuses', params: params

        expect(response).to have_http_status(204)
        expect(Slack::ApplicationJob).to have_received(:perform_later).once
        expect(Rails.logger).to have_received(:info).with("[Twilio][SmsStatus] To: +33651458411 Status: failed").once
      end
    end

    context 'undelivered status' do
      let(:status) { 'undelivered' }

      it 'alerts slack' do
        post '/twilio/sms_statuses', params: params

        expect(response).to have_http_status(204)
        expect(Slack::ApplicationJob).to have_received(:perform_later).once
        expect(Rails.logger).to have_received(:info).with("[Twilio][SmsStatus] To: +33651458411 Status: undelivered").once
      end
    end
  end
end
