class StandardSurvey::SetStatus
  def self.call(standard_survey)
    new(standard_survey).call
  end

  def initialize(standard_survey)
    @standard_survey = standard_survey
  end

  attr_reader :standard_survey

  def call
    return set_red_status if red_status?
    return set_orange_status if orange_status?
    return set_green_status if green_status?

    set_default_status
  end

  private

    def set_default_status
      standard_survey.update!(status: ::StandardSurvey::STATUS_YELLOW)
    end

    def red_status?
      [
        standard_survey.breathing_difficulty_borg_scale.to_f > 5.0,
        high_breathing_difficulty_borg_scale_variation
      ].any?
    end

    def set_red_status
      standard_survey.update!(status: ::StandardSurvey::STATUS_RED)
    end

    def orange_status?
      [
        standard_survey.body_temperature.to_f > 40,
        standard_survey.breathing_difficulty_borg_scale.to_f > 3.0,
        standard_survey.respiratory_rate_in_cycles_per_minute.to_i >= 22,
        !standard_survey.agreed_containment,
        standard_survey.body_temperature.to_f > 39 && standard_survey.breathing_difficulty_borg_scale.to_f > 2.0,
      ].any?
    end

    def set_orange_status
      standard_survey.update!(status: ::StandardSurvey::STATUS_ORANGE)
    end

    def green_status?
      [
        !standard_survey.cohabitants_recent_change,
        standard_survey.body_temperature.to_f < 38.5,
        standard_survey.breathing_difficulty_borg_scale.to_f <= 1.0,
        standard_survey.heartbeats_per_minute.to_i < 110,
        standard_survey.respiratory_rate_in_cycles_per_minute.to_i < 22,
        !standard_survey.recent_cold_chill,
        !standard_survey.recent_faintness,
        standard_survey.agreed_containment
      ].all?
    end

    def set_green_status
      standard_survey.update!(status: ::StandardSurvey::STATUS_GREEN)
    end

    def previous_completed_standard_survey
      standard_survey.previous_completed_standard_survey
    end

    def high_breathing_difficulty_borg_scale_variation
      return false unless previous_completed_standard_survey

      (standard_survey.breathing_difficulty_borg_scale.to_f - previous_completed_standard_survey.breathing_difficulty_borg_scale.to_f) > 2.0
    end

end