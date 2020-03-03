require 'rails_helper'

RSpec.describe UpdateStandardSurveyForm, type: :model do

  let(:patient)                               { create :patient }
  let(:standard_survey)                       { create :standard_survey, :empty, patient: patient }

  let(:otp)                                   { patient.generate_otp }
  let(:body_temperature)                      { 39.0 }
  let(:cohabitants_recent_change)             { true }
  let(:breathing_difficulty)                  { "1" }
  let(:breathing_difficulty_borg_scale)       { "0,5" }
  let(:heartbeats_per_minute)                 { 110 }
  let(:recent_faintness)                      { true }
  let(:agreed_containment)                    { true }
  let(:agreed_containment_comment)            { "comment" }

  let(:attributes) do
    {
      standard_survey: standard_survey,
      otp: otp,
      body_temperature: body_temperature,
      cohabitants_recent_change: cohabitants_recent_change,
      breathing_difficulty: breathing_difficulty,
      breathing_difficulty_borg_scale: breathing_difficulty_borg_scale,
      heartbeats_per_minute: heartbeats_per_minute,
      recent_faintness: recent_faintness,
      agreed_containment: agreed_containment,
      agreed_containment_comment: agreed_containment_comment
    }
  end

  let(:form) { UpdateStandardSurveyForm.new(attributes) }

  context 'with valid attributes' do
    it 'updates the StandardSurvey' do
      form.submit

      standard_survey.reload

      expect(standard_survey.body_temperature).to eq body_temperature
      expect(standard_survey.cohabitants_recent_change).to eq cohabitants_recent_change
      expect(standard_survey.breathing_difficulty).to eq breathing_difficulty
      expect(standard_survey.breathing_difficulty_borg_scale).to eq breathing_difficulty_borg_scale
      expect(standard_survey.heartbeats_per_minute).to eq heartbeats_per_minute
      expect(standard_survey.recent_faintness).to eq recent_faintness
      expect(standard_survey.agreed_containment).to eq agreed_containment
      expect(standard_survey.agreed_containment_comment).to eq agreed_containment_comment
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
