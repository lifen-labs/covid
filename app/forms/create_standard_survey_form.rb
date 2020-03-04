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
      "Vous êtes inscrits sur la plateforme pour la surveillance à domicile des patients infectés par le coronavirus Covid-19. Merci de compléter le questionnaire pour évaluer l’évolution de vos symptômes. Toutes les réponses seront analysées par des équipes médicales. En cas de problème, contactez le #{command_center.phone_number}.\n#{standard_survey.temporary_url}"
    end

    def command_center
      standard_survey.patient.command_center || CommandCenter.first
    end

end