class CreatePatientForm
  include ActiveModel::Model

  attr_accessor(
    :first_name,
    :last_name,
    :cellphone_number
  )

  attr_reader :patient

  validates_presence_of :first_name, :last_name, :cellphone_number

  def submit
    @patient = Patient.new(patient_attributes)

    if @patient.save
      return true
    end

    errors.merge!(patient.errors)

    false
  end

  private

    def patient_attributes
      {
        first_name: first_name,
        last_name: last_name,
        cellphone_number: cellphone_number
      }
    end

end