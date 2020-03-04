class Patient < ApplicationRecord
  validates_presence_of :first_name, :last_name, :cellphone_number, :otp_secret

  phony_normalize :cellphone_number, default_country_code: 'FR'
  phony_normalize :relative_cellphone_number, default_country_code: 'FR'

  has_many :standard_surveys, dependent: :destroy
  belongs_to :command_center, optional: true

  enum gender: {male: 'male', female: 'female'}, _prefix: true
  enum covid_initial_symptom: {mild: 'mild', post_severe: 'post_severe', post_critical: 'post_critical'}, _prefix: true
  enum comorbidity_smoking: {yes: 'yes', never: 'never', former_smoker: 'former_smoker'}, _prefix: true

  scope :green,                              -> { where(latest_standard_survey_status: ::StandardSurvey::STATUS_GREEN)}
  scope :yellow,                             -> { where(latest_standard_survey_status: ::StandardSurvey::STATUS_YELLOW)}
  scope :orange,                             -> { where(latest_standard_survey_status: ::StandardSurvey::STATUS_ORANGE)}
  scope :red,                                -> { where(latest_standard_survey_status: ::StandardSurvey::STATUS_RED)}
  scope :without_completed_standard_survey,  -> { where(latest_standard_survey_status: nil)}

  def to_s
    return "Patient ##{id}" if first_name.blank? && last_name.blank?

    "#{first_name} #{last_name}"
  end

  def display_name
    to_s
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

  def comorbibity?
    [
      comorbidity_chronic_cardiac_disease?,
      comorbidity_chronic_pulmonary_disease?,
      comorbidity_asthma?,
      comorbidity_chronic_kidney_disease?,
      comorbidity_liver_disease?,
      comorbidity_mild_liver_disease?,
      comorbidity_chronic_neurological_disorder?,
      comorbidity_malignant_neoplasia?,
      comorbidity_chronic_hemathological_disease?,
      comorbidity_hiv?,
      comorbidity_obesity?,
      comorbidity_diabetes_with_complications?,
      comorbidity_diabetes?,
      comorbidity_rheumatologic_disease?,
      comorbidity_dementia?,
      comorbidity_malnutrition?,
      comorbidity_smoking == "yes",
      comorbidity_other?,
    ].any?
  end

end
