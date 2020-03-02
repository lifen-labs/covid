class AddOtpSecretToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :otp_secret, :string
    add_index :patients, :otp_secret, unique: true
  end
end
