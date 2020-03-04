class CreateStandardSurveyForm
  include ActiveModel::Model

  attr_accessor(
    :patient
  )

  attr_reader :standard_survey

  validates_presence_of :patient

  def submit
    return false unless valid?

    @standard_survey = patient.standard_surveys.new

    if @standard_survey.save
      safely_send_sms

      return true
    end

    errors.merge!(standard_survey.errors)

    false
  end

  def submit!
    raise StandardError unless submit
  end


  private

    def safely_send_sms
      Raven.extra_context(standard_survey_id: standard_survey.id)

      SendSms.call(standard_survey.patient.cellphone_number, sms_message)
    rescue StandardError => e
      Raven.capture_exception(e)
    end

    def sms_message
      return default_sms_message if standard_survey.patient.gender.blank? || standard_survey.patient.last_name.blank?

      "Bonjour #{gender_to_text} #{standard_survey.patient.last_name}, merci de remplir votre questionnaire de suivi : #{standard_survey.temporary_url}"
    end

    def gender_to_text
      I18n.t("activerecord.attributes.patient.genders_to_text.#{standard_survey.patient.gender}")
    end

    def default_sms_message
      "Bonjour, merci de remplir votre questionnaire de suivi : #{standard_survey.temporary_url}"
    end
end