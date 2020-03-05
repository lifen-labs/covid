require 'rails_helper'

RSpec.describe CreateStandardSurveyJob, type: :model do

  let!(:patient_to_notify)        { create :patient }
  let!(:patient_not_to_notify)    { create :patient }
  let!(:patient_inactive)         { create :patient, active: false }

  let!(:standard_survey)          { create :standard_survey, patient: patient_not_to_notify }

  let(:job)                       { CreateStandardSurveyJob }

  before(:each) do
    allow(SendSms).to receive(:call)
  end

  it 'creates the necessary standard surveys' do
    expect{
      job.perform_now
    }.to change(StandardSurvey, :count).by(1)

    expect(patient_to_notify.standard_surveys.count).to eq 1
  end

end
