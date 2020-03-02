class CreateStandardSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :standard_surveys do |t|
      t.references :patient, null: false, foreign_key: true
      t.float :body_temperature
      t.datetime :completed_at
      t.string :public_token

      t.timestamps
    end

    add_index :standard_surveys, :public_token, unique: true
  end
end
