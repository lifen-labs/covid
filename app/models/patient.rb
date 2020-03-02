class Patient < ApplicationRecord
  validates_presence_of :first_name, :last_name, :cellphone_number, :otp_secret

  phony_normalize :cellphone_number, default_country_code: 'FR'

  has_many :standard_surveys, dependent: :destroy

  def to_s
    "#{first_name} #{last_name}"
  end

  def otp_service
    @_otp_service ||= ROTP::TOTP.new(otp_secret, issuer: 'Authentication service')
  end

  def generate_otp
    otp_service.now
  end

  def verify_otp(code_to_check)
    otp_service.verify(code_to_check || '', drift_behind: 1.day.to_i)
  end

end
