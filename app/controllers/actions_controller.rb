class ActionsController < ApplicationController

  before_action :authenticate_admin_user!

  def new
    @form = CreateActionForm.new(standard_survey: standard_survey)
  end

  def create
    @form = CreateActionForm.new(standard_survey_params)

    if @form.submit
      redirect_to admin_standard_survey_path(standard_survey), notice: 'Action effectuée'
    else
      render :new
    end
  end


  private

    def standard_survey
      @_standard_survey = StandardSurvey.find(params[:id])
    end


    def standard_survey_params
      params.require(:create_action_form)
            .permit(:action_comment)
            .merge(standard_survey: standard_survey)
    end

end