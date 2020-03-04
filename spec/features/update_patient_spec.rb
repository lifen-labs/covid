require 'rails_helper'

RSpec.describe 'updating a Patient', type: :feature do
  let(:patient)                                         { create :patient }
  let(:other_patient)                                   { build_stubbed :patient }

  let(:first_name)                                      { other_patient.first_name }
  let(:last_name)                                       { other_patient.last_name }
  let(:cellphone_number)                                { other_patient.cellphone_number }
  let(:address)                                         { other_patient.address }
  let(:email)                                           { other_patient.email }
  let(:relative_cellphone_number)                       { other_patient.relative_cellphone_number }
  let(:general_practitioner)                            { other_patient.general_practitioner }
  let(:covid_general_practitioner)                      { other_patient.covid_general_practitioner }
  let(:gender)                                          { other_patient.gender }
  let(:birthdate)                                       { other_patient.birthdate }
  let(:is_healthcare_professional)                      { other_patient.is_healthcare_professional }
  let(:pregnant)                                        { other_patient.pregnant }
  let(:home_caregivers)                                 { other_patient.home_caregivers }
  let(:home_caregivers_type)                            { other_patient.home_caregivers_type }
  let(:covid_initial_symptom)                           { other_patient.covid_initial_symptom }
  let(:covid_initial_symptoms_diagnosed_on)             { other_patient.covid_initial_symptoms_diagnosed_on }
  let(:covid_initial_symptoms_started_on)               { other_patient.covid_initial_symptoms_started_on }
  let(:covid_treatment_started_on)                      { other_patient.covid_treatment_started_on }
  let(:interstitial_alveolus_infiltrates)               { other_patient.interstitial_alveolus_infiltrates }
  let(:notable_long_term_treatments)                    { other_patient.notable_long_term_treatments }
  let(:sars_cov_2_treatment)                            { other_patient.sars_cov_2_treatment }
  let(:sars_cov_2_treatment_name)                       { other_patient.sars_cov_2_treatment_name }
  let(:home_follow_up_elligible)                        { other_patient.home_follow_up_elligible }

  describe 'Updating a Patient', js: true do
    context 'authenticated' do
      let(:admin_user) { create :admin_user }

      before(:each) do
        admin_sign_in_with(admin_user)
      end

      context 'with valid attributes' do
        it 'creates the Patient', js: true do
          visit edit_patient_path(patient)

          fill_in :update_patient_form_first_name, with: first_name

          click_on 'Mettre à jour'

          patient.reload

          expect(patient.first_name).to eq first_name
        end
      end
    end

    context 'unauthenticated' do
      it 'prevents the Patient creation' do
        visit edit_patient_path(patient)

        expect(body).to have_content('Vous devez vous connecter ou vous inscrire pour continuer.')
      end
    end
  end
end