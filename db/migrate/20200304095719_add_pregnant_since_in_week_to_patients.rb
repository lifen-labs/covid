class AddPregnantSinceInWeekToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :pregnant_since_in_weeks, :integer
  end
end
