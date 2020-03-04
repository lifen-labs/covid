ActiveAdmin.register Patient do
  actions :index, :show

  controller do
    def scoped_collection
      super.includes(:command_center)
    end
  end

  scope "Rouge", :red, default: true
  scope "Orange", :orange
  scope "Jaune", :yellow
  scope "Vert", :green
  scope "Non répondants", :without_completed_standard_survey
  scope "Tous", :all

  index do
    column(:latest_standard_survey_status) { |patient| status_tag(StandardSurvey.human_enum_name('status', patient.latest_standard_survey_status), class: "standard_survey_status_#{patient.latest_standard_survey_status}") }
    column("Comorbidité ?") {|p| status_tag(p.comorbibity?) }
    column :command_center
    column(:first_name) {|p| link_to p.first_name, admin_patient_path(p)}
    column(:last_name) {|p| link_to p.last_name, admin_patient_path(p)}
    column :cellphone_number
    column :created_at
    actions
  end

  filter :command_center
  filter :latest_standard_survey_status, as: :select, collection: StandardSurvey.enum_filter_collection('status')
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

  sidebar "Informations principales", only: :show do
    attributes_table_for patient, :command_center, :gender, :first_name, :last_name, :birthdate, :cellphone_number, :email, :created_at, :updated_at, :survey_periodicity_in_hours
  end

  show title: :to_s do
    panel "Réponses" do
      table_for(patient.standard_surveys.order(created_at: :desc)) do
        column('') { |standard_survey| link_to "voir", admin_standard_survey_path(standard_survey) }
        column(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
        column :body_temperature
        column :breathing_difficulty_borg_scale
        column :created_at
        column :completed_at
        column :action_comment
      end
    end

    panel "Informations générales" do
      columns do
        column do
          attributes_table_for patient, :relative_cellphone_number, :general_practitioner, :covid_general_practitioner, :is_healthcare_professional, :pregnant, :home_caregivers, :home_caregivers_type
        end
        column do
          attributes_table_for patient, :covid_initial_symptom, :covid_initial_symptoms_diagnosed_on, :covid_initial_symptoms_started_on, :covid_treatment_started_on, :interstitial_alveolus_infiltrates, :notable_long_term_treatments, :sars_cov_2_treatment, :sars_cov_2_treatment_name, :home_follow_up_elligible
        end
      end
    end

    panel "Comorbidité" do
      columns do
        column do
          attributes_table_for patient, :comorbidity_chronic_cardiac_disease, :comorbidity_chronic_pulmonary_disease, :comorbidity_asthma, :comorbidity_chronic_kidney_disease, :comorbidity_liver_disease, :comorbidity_mild_liver_disease, :comorbidity_chronic_neurological_disorder, :comorbidity_malignant_neoplasia, :comorbidity_chronic_hemathological_disease, :comorbidity_hiv
        end
        column do
          attributes_table_for patient, :comorbidity_obesity, :comorbidity_diabetes_with_complications, :comorbidity_diabetes, :comorbidity_rheumatologic_disease, :comorbidity_dementia, :comorbidity_malnutrition, :comorbidity_smoking, :comorbidity_other, :comorbidity_other_comment
        end
      end
    end
  end
end
