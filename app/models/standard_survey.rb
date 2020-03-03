class StandardSurvey < ApplicationRecord
  include Tokenable
  has_token :public
  after_create :set_public_token

  include UrlHelper

  belongs_to :patient

  def temporary_url
    url_helper.edit_standard_survey_url(id: public_token, otp: patient.generate_otp)
  end

end
