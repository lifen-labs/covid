class CreateCommandCenters < ActiveRecord::Migration[6.0]
  def change
    create_table :command_centers do |t|
      t.string :name
      t.string :city

      t.timestamps
    end

    add_reference :patients, :command_center, index: true
    add_foreign_key :patients, :command_centers
  end
end
