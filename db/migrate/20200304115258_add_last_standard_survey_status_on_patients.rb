class AddLastStandardSurveyStatusOnPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :latest_standard_survey_status, :string
  end
end
