class AddAttributesToStandardSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :standard_surveys, :respiratory_rate_in_cycles_per_minute, :integer
    add_column :standard_surveys, :recent_cold_chill, :boolean
  end
end
