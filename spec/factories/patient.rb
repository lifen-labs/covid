FactoryBot.define do
  factory :patient do
    association                               :command_center
    first_name                                { FFaker::NameFR.first_name }
    last_name                                 { FFaker::NameFR.last_name }
    cellphone_number                          { "+33#{rand(6..7)}#{rand(0..99_999_999).to_s.rjust(8, '0')}" }
    otp_secret                                { ROTP::Base32.random }
    survey_periodicity_in_hours               { 24 }
    active                                    { true }

    gender                                    { "male" }
    birthdate                                 { 30.years.ago }
    pregnant                                  { false }
    pregnant_since_in_weeks                   { 0 }
    comorbidity_chronic_cardiac_disease       { false }
    comorbidity_chronic_pulmonary_disease     { false }
    comorbidity_asthma                        { false }
    comorbidity_chronic_kidney_disease        { false }
    comorbidity_liver_disease                 { false }
    comorbidity_mild_liver_disease            { false }
    comorbidity_chronic_neurological_disorder { false }
    comorbidity_malignant_neoplasia           { false }
    comorbidity_chronic_hemathological_disease{ false }
    comorbidity_hiv                           { false }
    comorbidity_obesity                       { false }
    comorbidity_diabetes_with_complications   { false }
    comorbidity_diabetes                      { false }
    comorbidity_rheumatologic_disease         { false }
    comorbidity_dementia                      { false }
    comorbidity_malnutrition                  { false }
    comorbidity_smoking                       { "yes" }
    covid_initial_symptoms_started_on         { 2.days.ago }
    interstitial_alveolus_infiltrates         { false }
    sars_cov_2_treatment                      { false }
    home_caregivers                           { false }
  end
end