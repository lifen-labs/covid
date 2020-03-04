class AddActionNeededOnStandardSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :standard_surveys, :action_needed, :boolean, default: false
    add_column :standard_surveys, :action_done_at, :datetime
  end
end
