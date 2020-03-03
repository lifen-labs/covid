ActiveAdmin.register Patient do
  actions :index, :show

  index do
    id_column
    column :first_name
    column :last_name
    column :cellphone_number
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :cellphone_number
  filter :address
  filter :email
  filter :relative_cellphone_number
  filter :general_practitioner
  filter :covid_general_practitioner
  filter :gender
  filter :birthdate
  filter :is_healthcare_professional
  filter :pregnant
  filter :home_caregivers
  filter :home_caregivers_type
  filter :covid_initial_symptom
  filter :covid_initial_symptoms_diagnosed_on
  filter :covid_initial_symptoms_started_on
  filter :covid_treatment_started_on
  filter :interstitial_alveolus_infiltrates
  filter :notable_long_term_treatments
  filter :sars_cov_2_treatment
  filter :sars_cov_2_treatment_name
  filter :home_follow_up_elligible
  filter :comorbidity_chronic_cardiac_disease
  filter :comorbidity_chronic_pulmonary_disease
  filter :comorbidity_asthma
  filter :comorbidity_chronic_kidney_disease
  filter :comorbidity_liver_disease
  filter :comorbidity_mild_liver_disease
  filter :comorbidity_chronic_neurological_disorder
  filter :comorbidity_malignant_neoplasia
  filter :comorbidity_chronic_hemathological_disease
  filter :comorbidity_hiv
  filter :comorbidity_obesity
  filter :comorbidity_diabetes_with_complications
  filter :comorbidity_diabetes
  filter :comorbidity_rheumatologic_disease
  filter :comorbidity_dementia
  filter :comorbidity_malnutrition
  filter :comorbidity_smoking
  filter :comorbidity_other
  filter :comorbidity_other_comment
  filter :created_at

  action_item(:new_patient, only: :index) do
    link_to 'Nouveau Patient', new_patient_path
  end

  action_item(:edit_patient, only: :show) do
    link_to 'Modifier', edit_patient_path(patient)
  end

  action_item(:new_standard_survey, only: :show) do
    link_to 'Créer un questionnaire standard', create_standard_survey_admin_patient_path(patient)
  end

  member_action :create_standard_survey, method: :get do
    patient = Patient.find(params[:id])

    form = CreateStandardSurveyForm.new(patient: patient)

    if form.submit
      redirect_to admin_standard_survey_path(form.standard_survey), notice: 'Questionnaire standard créé'
    else
      redirect_to admin_patient_path(patient), alert: 'Erreur lors de la création du questionnaire standard'
    end
  end
end
