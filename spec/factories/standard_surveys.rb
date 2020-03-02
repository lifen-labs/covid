FactoryBot.define do
  factory :standard_survey do
    association           :patient
    body_temperature      { 37.2 }
  end
end
