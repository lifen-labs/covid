require 'rails_helper'

RSpec.describe 'standard_surveys', type: :feature do
  let(:admin_user)          { create :admin_user }
  let!(:standard_survey)    { create :standard_survey }

  before(:each) do
    admin_sign_in_with(admin_user)
  end

  it 'index' do
    visit admin_standard_surveys_path
  end

  it 'show' do
    visit admin_standard_survey_path(standard_survey)
  end
end