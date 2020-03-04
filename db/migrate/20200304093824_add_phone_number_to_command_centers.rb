class AddPhoneNumberToCommandCenters < ActiveRecord::Migration[6.0]
  def change
    add_column :command_centers, :phone_number, :string
  end
end
