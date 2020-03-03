class AddStandardSurveyAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :standard_surveys, :cohabitants_recent_change, :boolean
    add_column :standard_surveys, :breathing_difficulty, :integer
    add_column :standard_surveys, :breathing_difficulty_borg_scale, :float
    add_column :standard_surveys, :heartbeats_per_minute, :integer
    add_column :standard_surveys, :recent_faintness, :boolean
    add_column :standard_surveys, :agreed_containment, :boolean
    add_column :standard_surveys, :agreed_containment_comment, :text
  end
end


