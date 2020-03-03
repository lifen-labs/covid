class AddStatusToStandardSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :standard_surveys, :status, :string
  end
end
