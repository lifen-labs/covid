class RenameRecentFaintnessOnStandardSurveys < ActiveRecord::Migration[6.0]
  def change
    rename_column(:standard_surveys, :recent_faintness, :recent_chest_pain)
  end
end
