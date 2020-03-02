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
  filter :created_at

  action_item(:new_patient, only: :index) do
    link_to 'Nouveau Patient', new_patient_path
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
