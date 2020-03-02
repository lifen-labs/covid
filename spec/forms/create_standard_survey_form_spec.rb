require 'rails_helper'

RSpec.describe CreateStandardSurveyForm, type: :model do

  let(:patient) { create :patient }

  let(:attributes) do
    {
      patient: patient
    }
  end

  let(:form) { CreateStandardSurveyForm.new(attributes) }

  context 'with valid attributes' do
    it 'creates a StandardSurvey' do
      expect {
        form.submit
      }.to change(StandardSurvey, :count).by(1)

      standard_survey = form.standard_survey

      expect(standard_survey.patient).to eq patient
    end
  end

  context 'when patient is missing' do
    let(:patient) { nil }

    it 'prevents the creation' do
      expect {
        form.submit
      }.to_not change(StandardSurvey, :count)
    end
  end
end
