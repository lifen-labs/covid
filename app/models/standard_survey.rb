class StandardSurvey < ApplicationRecord
  include Tokenable
  has_token :public
  after_create :set_public_token

  include UrlHelper

  belongs_to :patient

  enum breathing_difficulty: {"1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5}, _prefix: true
  enum breathing_difficulty_borg_scale: {"1" => 1, "0,5" => 0.5, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10}, _prefix: true

  scope :completed, -> { where.not(completed_at: nil)}
  scope :to_complete, -> { where(completed_at: nil)}

  def temporary_url
    url_helper.edit_standard_survey_url(id: public_token, otp: patient.generate_otp)
  end

end
