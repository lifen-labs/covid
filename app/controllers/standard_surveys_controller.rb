class StandardSurveysController < ApplicationController

  def edit
    @form = UpdateStandardSurveyForm.new(standard_survey: standard_survey, otp: params[:otp])
  end

  def update
    @form = UpdateStandardSurveyForm.new(standard_survey_params)
    @form.standard_survey = standard_survey

    if @form.submit
      flash[:success] = "Questionnaire renseigné avec succès."
      render :update
    else
      render :edit
    end
  end

  private

    def standard_survey
      @_standard_survey = StandardSurvey.find_by!(public_token: params[:id])
    end


    def standard_survey_params
      params.require(:update_standard_survey_form).permit(:body_temperature, :cohabitants_recent_change, :breathing_difficulty, :breathing_difficulty_borg_scale, :heartbeats_per_minute, :recent_faintness, :agreed_containment, :agreed_containment_comment, :otp)
    end

end