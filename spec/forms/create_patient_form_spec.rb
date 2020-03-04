require 'rails_helper'

RSpec.describe CreatePatientForm, type: :model do

  let(:patient)                                         { build_stubbed :patient }

  let(:command_center)                                  { create :command_center }

  let(:first_name)                                      { patient.first_name }
  let(:last_name)                                       { patient.last_name }
  let(:cellphone_number)                                { patient.cellphone_number }
  let(:address)                                         { patient.address }
  let(:email)                                           { patient.email }
  let(:relative_cellphone_number)                       { patient.relative_cellphone_number }
  let(:general_practitioner)                            { patient.general_practitioner }
  let(:covid_general_practitioner)                      { patient.covid_general_practitioner }
  let(:gender)                                          { patient.gender }
  let(:birthdate)                                       { patient.birthdate }
  let(:is_healthcare_professional)                      { patient.is_healthcare_professional }
  let(:pregnant)                                        { patient.pregnant.to_s }
  let(:pregnant_since_in_weeks)                         { patient.pregnant_since_in_weeks }
  let(:home_caregivers)                                 { patient.home_caregivers.to_s }
  let(:home_caregivers_type)                            { patient.home_caregivers_type }
  let(:covid_initial_symptom)                           { patient.covid_initial_symptom.to_s }
  let(:covid_initial_symptoms_diagnosed_on)             { patient.covid_initial_symptoms_diagnosed_on }
  let(:covid_initial_symptoms_started_on)               { patient.covid_initial_symptoms_started_on }
  let(:covid_treatment_started_on)                      { patient.covid_treatment_started_on }
  let(:interstitial_alveolus_infiltrates)               { patient.interstitial_alveolus_infiltrates.to_s }
  let(:notable_long_term_treatments)                    { patient.notable_long_term_treatments.to_s }
  let(:sars_cov_2_treatment)                            { patient.sars_cov_2_treatment.to_s }
  let(:sars_cov_2_treatment_name)                       { patient.sars_cov_2_treatment_name }
  let(:home_follow_up_elligible)                        { patient.home_follow_up_elligible.to_s }

  let(:comorbidity_chronic_cardiac_disease)             { patient.comorbidity_chronic_cardiac_disease.to_s }
  let(:comorbidity_chronic_pulmonary_disease)           { patient.comorbidity_chronic_pulmonary_disease.to_s }
  let(:comorbidity_asthma)                              { patient.comorbidity_asthma.to_s }
  let(:comorbidity_chronic_kidney_disease)              { patient.comorbidity_chronic_kidney_disease.to_s }
  let(:comorbidity_liver_disease)                       { patient.comorbidity_liver_disease.to_s }
  let(:comorbidity_mild_liver_disease)                  { patient.comorbidity_mild_liver_disease.to_s }
  let(:comorbidity_chronic_neurological_disorder)       { patient.comorbidity_chronic_neurological_disorder.to_s }
  let(:comorbidity_malignant_neoplasia)                 { patient.comorbidity_malignant_neoplasia.to_s }
  let(:comorbidity_chronic_hemathological_disease)      { patient.comorbidity_chronic_hemathological_disease.to_s }
  let(:comorbidity_hiv)                                 { patient.comorbidity_hiv.to_s }
  let(:comorbidity_obesity)                             { patient.comorbidity_obesity.to_s }
  let(:comorbidity_diabetes_with_complications)         { patient.comorbidity_diabetes_with_complications.to_s }
  let(:comorbidity_diabetes)                            { patient.comorbidity_diabetes.to_s }
  let(:comorbidity_rheumatologic_disease)               { patient.comorbidity_rheumatologic_disease.to_s }
  let(:comorbidity_dementia)                            { patient.comorbidity_dementia.to_s }
  let(:comorbidity_malnutrition)                        { patient.comorbidity_malnutrition.to_s }
  let(:comorbidity_smoking)                             { patient.comorbidity_smoking.to_s }
  let(:comorbidity_other)                               { patient.comorbidity_other.to_s }
  let(:comorbidity_other_comment)                       { patient.comorbidity_other_comment.to_s }

  let(:attributes) do
    {
      first_name: first_name,
      last_name: last_name,
      cellphone_number: cellphone_number,
      address: address,
      email: email,
      relative_cellphone_number: relative_cellphone_number,
      general_practitioner: general_practitioner,
      covid_general_practitioner: covid_general_practitioner,
      gender: gender,
      birthdate: birthdate,
      is_healthcare_professional: is_healthcare_professional,
      pregnant: pregnant,
      pregnant_since_in_weeks: pregnant_since_in_weeks,
      home_caregivers: home_caregivers,
      home_caregivers_type: home_caregivers_type,
      covid_initial_symptom: covid_initial_symptom,
      covid_initial_symptoms_diagnosed_on: covid_initial_symptoms_diagnosed_on,
      covid_initial_symptoms_started_on: covid_initial_symptoms_started_on,
      covid_treatment_started_on: covid_treatment_started_on,
      interstitial_alveolus_infiltrates: interstitial_alveolus_infiltrates,
      notable_long_term_treatments: notable_long_term_treatments,
      sars_cov_2_treatment: sars_cov_2_treatment,
      sars_cov_2_treatment_name: sars_cov_2_treatment_name,
      home_follow_up_elligible: home_follow_up_elligible,
      comorbidity_chronic_cardiac_disease: comorbidity_chronic_cardiac_disease,
      comorbidity_chronic_pulmonary_disease: comorbidity_chronic_pulmonary_disease,
      comorbidity_asthma: comorbidity_asthma,
      comorbidity_chronic_kidney_disease: comorbidity_chronic_kidney_disease,
      comorbidity_liver_disease: comorbidity_liver_disease,
      comorbidity_mild_liver_disease: comorbidity_mild_liver_disease,
      comorbidity_chronic_neurological_disorder: comorbidity_chronic_neurological_disorder,
      comorbidity_malignant_neoplasia: comorbidity_malignant_neoplasia,
      comorbidity_chronic_hemathological_disease: comorbidity_chronic_hemathological_disease,
      comorbidity_hiv: comorbidity_hiv,
      comorbidity_obesity: comorbidity_obesity,
      comorbidity_diabetes_with_complications: comorbidity_diabetes_with_complications,
      comorbidity_diabetes: comorbidity_diabetes,
      comorbidity_rheumatologic_disease: comorbidity_rheumatologic_disease,
      comorbidity_dementia: comorbidity_dementia,
      comorbidity_malnutrition: comorbidity_malnutrition,
      comorbidity_smoking: comorbidity_smoking,
      comorbidity_other: comorbidity_other,
      comorbidity_other_comment: comorbidity_other_comment,
      command_center_id: command_center.id
    }
  end

  let(:form) { CreatePatientForm.new(attributes) }

  context 'with valid attributes' do
    it 'creates a Patient' do
      expect {
        form.submit
        ap form.errors.messages
      }.to change(Patient, :count).by(1)

      patient = form.patient

      expect(patient.first_name).to eq first_name
      expect(patient.otp_secret).to_not be_nil
      expect(patient.command_center).to eq command_center
    end
  end

  context 'when first_name is missing' do
    let(:first_name) { nil }

    it 'prevents the creation' do
      expect {
        form.submit
      }.to_not change(Patient, :count)
    end
  end
end
