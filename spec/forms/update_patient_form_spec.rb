require 'rails_helper'

RSpec.describe UpdatePatientForm, type: :model do

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

  let(:comorbidity_chronic_cardiac_disease)             { other_patient.comorbidity_chronic_cardiac_disease }
  let(:comorbidity_chronic_pulmonary_disease)           { other_patient.comorbidity_chronic_pulmonary_disease }
  let(:comorbidity_asthma)                              { other_patient.comorbidity_asthma }
  let(:comorbidity_chronic_kidney_disease)              { other_patient.comorbidity_chronic_kidney_disease }
  let(:comorbidity_liver_disease)                       { other_patient.comorbidity_liver_disease }
  let(:comorbidity_mild_liver_disease)                  { other_patient.comorbidity_mild_liver_disease }
  let(:comorbidity_chronic_neurological_disorder)       { other_patient.comorbidity_chronic_neurological_disorder }
  let(:comorbidity_malignant_neoplasia)                 { other_patient.comorbidity_malignant_neoplasia }
  let(:comorbidity_chronic_hemathological_disease)      { other_patient.comorbidity_chronic_hemathological_disease }
  let(:comorbidity_hiv)                                 { other_patient.comorbidity_hiv }
  let(:comorbidity_obesity)                             { other_patient.comorbidity_obesity }
  let(:comorbidity_diabetes_with_complications)         { other_patient.comorbidity_diabetes_with_complications }
  let(:comorbidity_diabetes)                            { other_patient.comorbidity_diabetes }
  let(:comorbidity_rheumatologic_disease)               { other_patient.comorbidity_rheumatologic_disease }
  let(:comorbidity_dementia)                            { other_patient.comorbidity_dementia }
  let(:comorbidity_malnutrition)                        { other_patient.comorbidity_malnutrition }
  let(:comorbidity_smoking)                             { other_patient.comorbidity_smoking }
  let(:comorbidity_other)                               { other_patient.comorbidity_other }
  let(:comorbidity_other_comment)                       { other_patient.comorbidity_other_comment }

  let(:attributes) do
    {
      patient: patient,
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
      comorbidity_other_comment: comorbidity_other_comment
    }
  end

  let(:form) { UpdatePatientForm.new(attributes) }

  context 'with valid attributes' do
    it 'updates a Patient' do
      previous_otp_secret = patient.otp_secret

      form.submit

      patient.reload

      expect(patient.first_name).to eq first_name
      expect(patient.otp_secret).to eq previous_otp_secret
    end
  end
end
