require 'rails_helper'

RSpec.describe CreateActionForm, type: :model do

  let(:patient)                               { create :patient }
  let(:standard_survey)                       { create :standard_survey, :empty, patient: patient }

  let(:action_comment)                        { "comment" }

  let(:attributes) do
    {
      standard_survey: standard_survey,
      action_comment: action_comment
    }
  end

  let(:form) { CreateActionForm.new(attributes) }

  context 'with valid attributes' do
    it 'updates the StandardSurvey' do
      form.submit

      standard_survey.reload

      expect(standard_survey.action_comment).to eq action_comment
      expect(standard_survey.action_done_at).to_not be_nil
    end

    context 'without action_comment' do
      let(:action_comment) { nil }

      it 'does nothing' do
        expect(form.submit).to be_falsy
      end
    end
  end
end
