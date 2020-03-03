class AddSurveyPeriodicityToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :survey_periodicity_in_hours, :integer, default: 24
  end
end
