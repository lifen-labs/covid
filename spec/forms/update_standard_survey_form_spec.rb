require 'rails_helper'

RSpec.describe UpdateStandardSurveyForm, type: :model do

  let(:patient)                               { create :patient }
  let(:standard_survey)                       { create :standard_survey, :empty, patient: patient }

  let(:otp)                                   { patient.generate_otp }
  let(:body_temperature)                      { 39.0 }
  let(:cohabitants_recent_change)             { true }
  let(:breathing_difficulty_borg_scale)       { "0,5" }
  let(:heartbeats_per_minute)                 { 110 }
  let(:recent_chest_pain)                     { true }
  let(:agreed_containment)                    { true }
  let(:agreed_containment_comment)            { "comment" }
  let(:respiratory_rate_in_cycles_per_minute) { 100 }
  let(:recent_cold_chill)                     { true }

  let(:attributes) do
    {
      standard_survey: standard_survey,
      otp: otp,
      body_temperature: body_temperature,
      cohabitants_recent_change: cohabitants_recent_change,
      breathing_difficulty_borg_scale: breathing_difficulty_borg_scale,
      heartbeats_per_minute: heartbeats_per_minute,
      recent_chest_pain: recent_chest_pain,
      agreed_containment: agreed_containment,
      agreed_containment_comment: agreed_containment_comment,
      respiratory_rate_in_cycles_per_minute: respiratory_rate_in_cycles_per_minute,
      recent_cold_chill: recent_cold_chill
    }
  end

  let(:form) { UpdateStandardSurveyForm.new(attributes) }

  context 'with valid attributes' do
    it 'updates the StandardSurvey' do
      form.submit

      standard_survey.reload

      expect(standard_survey.body_temperature).to eq body_temperature
      expect(standard_survey.cohabitants_recent_change).to eq cohabitants_recent_change
      expect(standard_survey.breathing_difficulty_borg_scale).to eq breathing_difficulty_borg_scale
      expect(standard_survey.heartbeats_per_minute).to eq heartbeats_per_minute
      expect(standard_survey.recent_chest_pain).to eq recent_chest_pain
      expect(standard_survey.agreed_containment).to eq agreed_containment
      expect(standard_survey.agreed_containment_comment).to eq agreed_containment_comment
      expect(standard_survey.respiratory_rate_in_cycles_per_minute).to eq respiratory_rate_in_cycles_per_minute
      expect(standard_survey.recent_cold_chill).to eq recent_cold_chill
      expect(standard_survey.completed_at).to_not be_nil

      expect(standard_survey.status).to_not be_nil
    end

    context 'without agreed_containment_comment' do
      let(:agreed_containment_comment) { nil }

      it 'updates the StandardSurvey' do
        expect(form.submit).to be_truthy
      end
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
