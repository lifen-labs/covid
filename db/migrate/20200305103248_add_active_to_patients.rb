class AddActiveToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :active, :boolean, default: true
  end
end
