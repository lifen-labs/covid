require 'rails_helper'

RSpec.describe 'updating a StandardSurvey', type: :feature do
  let(:patient)           { create :patient }
  let(:standard_survey)   { create :standard_survey, patient: patient, body_temperature: nil }

  let(:otp)               { patient.generate_otp }
  let(:body_temperature)  { "37,2" }

  describe 'updating a StandardSurvey' do
    let(:otp) { patient.generate_otp }

    context 'with valid attributes' do
      it 'updates the StandardSurvey' do
        visit edit_standard_survey_path(id: standard_survey.public_token, otp: otp)

        fill_in 'Température (°C)', with: body_temperature

        click_on 'Valider'

        standard_survey.reload

        expect(standard_survey.body_temperature).to eq 37.2
        expect(body).to have_content('Questionnaire renseigné avec succès.')
      end
    end

    context 'unauthenticated' do
      let(:otp) { 'invalid_otp' }

      it 'prevents the StandardSurvey update' do
        visit edit_standard_survey_path(id: standard_survey.public_token, otp: otp)

        fill_in 'Température (°C)', with: body_temperature

        click_on 'Valider'

        standard_survey.reload
        expect(standard_survey.body_temperature).to be_nil

        expect(body).to have_content("Otp n'est pas valide")
      end
    end
  end
end