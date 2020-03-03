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

  def needs_a_new_standard_survey?
    return true unless last_standard_survey

    last_standard_survey.created_at < survey_periodicity_in_hours.hours.ago
  end

  def last_standard_survey
    @_last_standard_survey ||= standard_surveys.order(created_at: :desc).take
  end

end
