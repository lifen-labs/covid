require 'rails_helper'

RSpec.describe 'creating a Patient', type: :feature do
  let(:patient)           { build_stubbed :patient }

  let(:first_name)        { patient.first_name }
  let(:last_name)         { patient.last_name }
  let(:cellphone_number)  { patient.cellphone_number }

  describe 'Creating a Patient', js: true do
    context 'authenticated' do
      let(:admin_user) { create :admin_user }

      before(:each) do
        admin_sign_in_with(admin_user)
      end

      context 'with valid attributes' do
        it 'creates the Patient', js: true do
          visit new_patient_path

          fill_in 'Numéro de portable', with: cellphone_number
          fill_in 'Prénom', with: first_name
          fill_in 'Nom', with: last_name

          expect {
            click_on 'Créer'
          }.to change(Patient, :count).by(1)
        end
      end
    end

    context 'unauthenticated' do
      it 'prevents the Patient creation' do
        visit new_patient_path

        expect(body).to have_content('Vous devez vous connecter ou vous inscrire pour continuer.')
      end
    end
  end
end