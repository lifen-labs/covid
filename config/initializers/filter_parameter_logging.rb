# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :password_confirmation, :first_name, :last_name, :cellphone_number, :otp_secret, :email, :public_token]