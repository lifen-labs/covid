class UpdateStandardSurveyForm
  include ActiveModel::Model

  attr_accessor(
    :standard_survey,
    :otp,
    :body_temperature,
    :cohabitants_recent_change,
    :breathing_difficulty_borg_scale,
    :heartbeats_per_minute,
    :recent_faintness,
    :agreed_containment,
    :agreed_containment_comment,
    :respiratory_rate_in_cycles_per_minute,
    :recent_cold_chill
  )

  validates_presence_of :standard_survey, :otp, :body_temperature, :cohabitants_recent_change, :breathing_difficulty_borg_scale, :heartbeats_per_minute, :recent_faintness, :agreed_containment, :respiratory_rate_in_cycles_per_minute, :recent_cold_chill
  validate :valid_otp

  def submit
    return false unless valid?

    standard_survey.attributes = standard_survey_attributes

    if standard_survey.save
      standard_survey.set_status!

      return true
    end

    errors.merge!(standard_survey.errors)

    false
  end

  private

    def standard_survey_attributes
      {
        body_temperature: filtered_body_temperature,
        cohabitants_recent_change: cohabitants_recent_change,
        breathing_difficulty_borg_scale: breathing_difficulty_borg_scale,
        heartbeats_per_minute: heartbeats_per_minute,
        recent_faintness: recent_faintness,
        agreed_containment: agreed_containment,
        agreed_containment_comment: agreed_containment_comment,
        respiratory_rate_in_cycles_per_minute: respiratory_rate_in_cycles_per_minute,
        recent_cold_chill: recent_cold_chill,
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