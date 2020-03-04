require 'rails_helper'

RSpec.describe 'patients', type: :feature do
  let(:admin_user)  { create :admin_user }
  let!(:patient)    { create :patient }

  before(:each) do
    admin_sign_in_with(admin_user)
  end

  it 'index' do
    visit admin_patients_path
  end

  it 'show' do
    visit admin_patient_path(patient)
  end
end
