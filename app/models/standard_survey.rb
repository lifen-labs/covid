class StandardSurvey < ApplicationRecord
  include Tokenable
  has_token :public
  after_create :set_public_token

  belongs_to :patient
end
