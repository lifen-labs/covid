require 'rails_helper'

RSpec.describe 'creating a StandardSurvey for a Patient', type: :feature do
  let(:patient)           { create :patient }

  describe 'Creating a StandardSurvey', js: true do
    context 'authenticated' do
      let(:admin_user) { create :admin_user }

      before(:each) do
        admin_sign_in_with(admin_user)
      end

      context 'with valid attributes' do
        it 'creates the StandardSurvey' do
          visit admin_patient_path(patient)

          expect {
            click_on "Créer un questionnaire standard"
          }.to change(patient.standard_surveys, :count).by(1)
        end
      end
    end

    context 'unauthenticated' do
      it 'prevents the StandardSurvey creation' do
        visit new_patient_path

        expect(body).to have_content('Vous devez vous connecter ou vous inscrire pour continuer.')
      end
    end
  end
end