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
      send_sms

      return true
    end

    errors.merge!(standard_survey.errors)

    false
  end

  private

    def send_sms
      SendSms.call(standard_survey.patient.cellphone_number, sms_message)
    end

    def sms_message
      standard_survey.temporary_url
    end

end