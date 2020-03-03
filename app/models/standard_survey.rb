class StandardSurvey < ApplicationRecord

  self.ignored_columns = ['breathing_difficulty']

  include Tokenable
  has_token :public
  after_create :set_public_token

  include UrlHelper

  belongs_to :patient

  STATUS_GREEN = 'green'.freeze
  STATUS_YELLOW = 'yellow'.freeze
  STATUS_ORANGE = 'orange'.freeze
  STATUS_RED = 'red'.freeze

  enum breathing_difficulty_borg_scale: {"0" => 0, "0,5" => 0.5, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10}, _prefix: true
  enum status: {green: STATUS_GREEN, yellow: STATUS_YELLOW, orange: STATUS_ORANGE, red: STATUS_RED}

  scope :completed,       -> { where.not(completed_at: nil)}
  scope :to_complete,     -> { where(completed_at: nil)}

  def temporary_url
    url_helper.edit_standard_survey_url(id: public_token, otp: patient.generate_otp)
  end

  def set_status!
    StandardSurvey::SetStatus.call(self)
  end
end
