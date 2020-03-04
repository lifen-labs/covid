require 'rails_helper'

RSpec.describe StandardSurvey::SetStatus, type: :model do

  subject(:service)           { StandardSurvey::SetStatus.new(standard_survey) }

  context 'green' do
    let(:standard_survey) { create :standard_survey, :green, status: nil }

    it 'sets the correct status' do
      service.call

      standard_survey.reload

      expect(standard_survey.status).to eq StandardSurvey::STATUS_GREEN
    end
  end

  context 'orange' do
    let(:standard_survey) { create :standard_survey, :orange, status: nil }

    it 'sets the correct status' do
      service.call

      standard_survey.reload

      expect(standard_survey.status).to eq StandardSurvey::STATUS_ORANGE
    end

    context 'high body_temperature' do
      let(:standard_survey) { create :standard_survey, status: nil, body_temperature: 40.1 }

      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_ORANGE
      end
    end

    context 'high breathing_difficulty_borg_scale' do
      let(:standard_survey) { create :standard_survey, status: nil, breathing_difficulty_borg_scale: '4' }

      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_ORANGE
      end
    end

    context 'high respiratory_rate_in_cycles_per_minute' do
      let(:standard_survey) { create :standard_survey, status: nil, respiratory_rate_in_cycles_per_minute: 22 }

      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_ORANGE
      end
    end

    context 'false agreed_containment' do
      let(:standard_survey) { create :standard_survey, status: nil, agreed_containment: false }

      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_ORANGE
      end
    end

    context 'combined body_temperature & breathing_difficulty_borg_scale' do
      let(:standard_survey) { create :standard_survey, status: nil, body_temperature: 39.1, breathing_difficulty_borg_scale: '3' }

      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_ORANGE
      end
    end
  end

  context 'red' do
    let(:standard_survey) { create :standard_survey, :red, status: nil }

    it 'sets the correct status' do
      service.call

      standard_survey.reload

      expect(standard_survey.status).to eq StandardSurvey::STATUS_RED
    end

    context 'high breathing_difficulty_borg_scale' do
      let(:standard_survey) { create :standard_survey, status: nil, breathing_difficulty_borg_scale: '7' }

      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_RED
      end
    end

    context 'high variation of breathing_difficulty_borg_scale' do
      let(:patient)                   { create :patient }
      let!(:previous_standard_survey) { create :standard_survey, :green, patient: patient, breathing_difficulty_borg_scale: '1' }
      let(:standard_survey)           { create :standard_survey, patient: patient, status: nil, breathing_difficulty_borg_scale: '4' }


      it 'sets the correct status' do
        service.call

        standard_survey.reload

        expect(standard_survey.status).to eq StandardSurvey::STATUS_RED
      end
    end
  end
end
