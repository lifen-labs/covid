require 'rails_helper'

RSpec.describe 'updating a StandardSurvey', type: :feature do
  let(:patient)                                { create :patient }
  let(:standard_survey)                        { create :standard_survey, patient: patient, body_temperature: nil }

  let(:otp)                                   { patient.generate_otp }
  let(:body_temperature)                      { "37,2" }
  let(:cohabitants_recent_change)             { "Oui" }
  let(:breathing_difficulty_borg_scale)       { "0.5 - Très, très légère" }
  let(:heartbeats_per_minute)                 { "110" }
  let(:respiratory_rate_in_cycles_per_minute) { "110" }
  let(:recent_faintness)                      { "Oui" }
  let(:recent_cold_chill)                     { "Oui" }
  let(:agreed_containment)                    { "Oui" }
  let(:agreed_containment_comment)            { "comment" }

  describe 'updating a StandardSurvey' do
    let(:otp) { patient.generate_otp }

    context 'with valid attributes' do
      it 'updates the StandardSurvey' do
        visit edit_standard_survey_path(id: standard_survey.public_token, otp: otp)

        fill_in :update_standard_survey_form_body_temperature, with: body_temperature
        choose(:update_standard_survey_form_cohabitants_recent_change_true)
        select breathing_difficulty_borg_scale, from: :update_standard_survey_form_breathing_difficulty_borg_scale
        fill_in :update_standard_survey_form_heartbeats_per_minute, with: heartbeats_per_minute
        fill_in :update_standard_survey_form_respiratory_rate_in_cycles_per_minute, with: respiratory_rate_in_cycles_per_minute
        choose(:update_standard_survey_form_recent_faintness_true)
        choose(:update_standard_survey_form_recent_cold_chill_true)
        choose(:update_standard_survey_form_agreed_containment_true)
        fill_in :update_standard_survey_form_agreed_containment_comment, with: agreed_containment_comment

        click_on 'Valider'

        standard_survey.reload

        expect(standard_survey.body_temperature).to eq 37.2
        expect(standard_survey.breathing_difficulty_borg_scale).to eq "0,5"
        expect(body).to have_content('Questionnaire renseigné avec succès.')
      end
    end

    context 'unauthenticated' do
      let(:otp) { 'invalid_otp' }

      it 'prevents the StandardSurvey update' do
        visit edit_standard_survey_path(id: standard_survey.public_token, otp: otp)

        fill_in :update_standard_survey_form_body_temperature, with: body_temperature
        choose(:update_standard_survey_form_cohabitants_recent_change_true)
        select breathing_difficulty_borg_scale, from: :update_standard_survey_form_breathing_difficulty_borg_scale
        fill_in :update_standard_survey_form_heartbeats_per_minute, with: heartbeats_per_minute
        fill_in :update_standard_survey_form_respiratory_rate_in_cycles_per_minute, with: respiratory_rate_in_cycles_per_minute
        choose(:update_standard_survey_form_recent_faintness_true)
        choose(:update_standard_survey_form_recent_cold_chill_true)
        choose(:update_standard_survey_form_agreed_containment_true)
        fill_in :update_standard_survey_form_agreed_containment_comment, with: agreed_containment_comment

        click_on 'Valider'

        standard_survey.reload
        expect(standard_survey.body_temperature).to be_nil

        expect(body).to have_content("Otp n'est pas valide")
      end
    end
  end
end