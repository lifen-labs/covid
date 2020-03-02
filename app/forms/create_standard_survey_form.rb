class CreateStandardSurveyForm
  include ActiveModel::Model

  attr_accessor(
    :patient
  )

  attr_reader :standard_survey

  validates_presence_of :patient

  def submit
    if valid?
       @standard_survey = patient.standard_surveys.new

      if @standard_survey.save
        return true
      end

      errors.merge!(standard_survey.errors)
    end

    false
  end

end