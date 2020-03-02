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

  private

    def patient_create_params
      params.require(:create_patient_form).permit(:first_name, :last_name, :cellphone_number)
    end

end
