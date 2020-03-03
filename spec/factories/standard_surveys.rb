FactoryBot.define do
  factory :standard_survey do
    association           :patient
    body_temperature      { 37.2 }

    trait(:empty) do
      body_temperature                    { nil }
      cohabitants_recent_change           { nil }
      breathing_difficulty                { nil }
      breathing_difficulty_borg_scale     { nil }
      heartbeats_per_minute               { nil }
      recent_faintness                    { nil }
      agreed_containment                  { nil }
      agreed_containment_comment          { nil }
    end
  end
end
