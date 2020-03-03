class CreatePatientForm < PatientForm

  attr_reader :patient

  def submit
    return false unless valid?

    @patient = Patient.new(patient_attributes)

    if @patient.save
      return true
    end

    errors.merge!(patient.errors)

    false
  end

  private

    def patient_attributes
      super.merge!({otp_secret: ROTP::Base32.random})
    end

end