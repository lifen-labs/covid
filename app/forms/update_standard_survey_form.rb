class UpdateStandardSurveyForm
  include ActiveModel::Model

  attr_accessor(
    :standard_survey,
    :otp,
    :body_temperature
  )

  validates_presence_of :standard_survey, :otp, :body_temperature
  validate :valid_otp

  def submit
    return false unless valid?

    standard_survey.attributes = standard_survey_attributes

    if standard_survey.save
      return true
    end

    errors.merge!(standard_survey.errors)

    false
  end

  private

    def standard_survey_attributes
      {
        body_temperature: filtered_body_temperature,
        completed_at: DateTime.current
      }
    end

    def valid_otp
      return if standard_survey.nil?

      errors.add(:otp, :invalid) unless standard_survey.patient.verify_otp(otp)
    end

    def filtered_body_temperature
      body_temperature.to_s.gsub(',', '.')
    end

end