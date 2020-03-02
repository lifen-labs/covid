require 'rails_helper'

RSpec.describe UpdateStandardSurveyForm, type: :model do

  let(:patient)           { create :patient }
  let(:standard_survey)   { create :standard_survey, patient: patient, body_temperature: nil }

  let(:otp)               { patient.generate_otp }
  let(:body_temperature)  { 39.0 }

  let(:attributes) do
    {
      standard_survey: standard_survey,
      otp: otp,
      body_temperature: body_temperature
    }
  end

  let(:form) { UpdateStandardSurveyForm.new(attributes) }

  context 'with valid attributes' do
    it 'updates the StandardSurvey' do
      form.submit

      standard_survey.reload

      expect(standard_survey.body_temperature).to eq body_temperature
      expect(standard_survey.completed_at).to_not be_nil
    end
  end

  context 'with incorrect OTP' do
    let(:otp) { 'incorrect_otp' }

    it 'prevents the update' do
      form.submit

      standard_survey.reload

      expect(standard_survey.body_temperature).to_not eq body_temperature
    end
  end
end
