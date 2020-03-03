class PatientsController < ApplicationController

  before_action :authenticate_admin_user!

  def new
    @form = CreatePatientForm.new
  end

  def create
    @form = CreatePatientForm.new(patient_create_params)

    if @form.submit
      redirect_to admin_patient_path(@form.patient), notice: 'Patient créé.'
    else
      render :new
    end
  end

  def edit
    @form = UpdatePatientForm.new(patient: patient)
    @form.assign_attributes_from_patient
  end

  def update
    @form = UpdatePatientForm.new(patient_update_params)

    if @form.submit
      redirect_to admin_patient_path(@form.patient), notice: 'Patient mis à jour.'
    else
      render :edit
    end
  end

  private

    def patient
      @_patient ||= Patient.find(params[:id])
    end


    def patient_create_params
      params.require(:create_patient_form).permit(patient_attributes)
    end

    def patient_update_params
      params.require(:update_patient_form).permit(patient_attributes).merge(patient: patient)
    end

    def patient_attributes
      [:first_name, :last_name, :cellphone_number, :address, :email, :relative_cellphone_number, :general_practitioner, :covid_general_practitioner, :gender, :birthdate, :is_healthcare_professional, :pregnant, :home_caregivers, :home_caregivers_type, :covid_initial_symptom, :covid_initial_symptoms_diagnosed_on, :covid_initial_symptoms_started_on, :covid_treatment_started_on, :interstitial_alveolus_infiltrates, :notable_long_term_treatments, :sars_cov_2_treatment, :sars_cov_2_treatment_name, :home_follow_up_elligible, :comorbidity_chronic_cardiac_disease, :comorbidity_chronic_pulmonary_disease, :comorbidity_asthma, :comorbidity_chronic_kidney_disease, :comorbidity_liver_disease, :comorbidity_mild_liver_disease, :comorbidity_chronic_neurological_disorder, :comorbidity_malignant_neoplasia, :comorbidity_chronic_hemathological_disease, :comorbidity_hiv, :comorbidity_obesity, :comorbidity_diabetes_with_complications, :comorbidity_diabetes, :comorbidity_rheumatologic_disease, :comorbidity_dementia, :comorbidity_malnutrition, :comorbidity_smoking, :comorbidity_other, :comorbidity_other_comment]
    end


end