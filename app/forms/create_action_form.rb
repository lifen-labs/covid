class CreateActionForm
  include ActiveModel::Model

  attr_accessor(
    :standard_survey,
    :action_comment
  )

  validates_presence_of :standard_survey, :action_comment

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
        action_comment: action_comment,
        action_done_at: DateTime.current
      }
    end

end