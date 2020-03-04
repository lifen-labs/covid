require 'rails_helper'

RSpec.describe 'standard_surveys', type: :feature do

  let(:admin_user)          { create :admin_user }
  let!(:standard_survey)    { create :standard_survey }

  context 'authenticated' do
    before(:each) do
      admin_sign_in_with(admin_user)
    end

    it 'index' do
      visit admin_standard_surveys_path
    end

    it 'show' do
      visit admin_standard_survey_path(standard_survey)
    end

    context 'doing actions' do

      let!(:standard_survey)    { create :standard_survey, action_needed: true, action_comment: nil }
      let(:action_comment)      { "comment" }

      it 'set the action as done' do
        visit admin_standard_survey_path(standard_survey)

        click_on "Marquer action faite"

        fill_in :create_action_form_action_comment, with: action_comment
        click_on "Action effectuée"

        expect(body).to have_content("Action effectuée")

        standard_survey.reload

        expect(standard_survey.action_comment).to eq action_comment
        expect(standard_survey.action_done_at).to_not be_nil
      end
    end
  end

  context 'authenticated' do
    it 'can not create an action' do
      visit new_action_path(standard_survey)

      expect(body).to have_content("Vous devez vous connecter ou vous inscrire pour continuer.")
    end
  end



end