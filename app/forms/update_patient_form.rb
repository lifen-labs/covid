class UpdatePatientForm < PatientForm
  attr_accessor :patient

  validates_presence_of :patient

  def submit
    return false unless valid?

    patient.attributes = patient_attributes

    if patient.save
      return true
    end

    errors.merge!(patient.errors)

    false
  end

  def assign_attributes_from_patient
    attributes_to_persist.each do |attr|
      public_send("#{attr}=", patient.public_send(attr))
    end
  end

  private

    def attributes_to_persist
      patient_attributes.keys
    end
end