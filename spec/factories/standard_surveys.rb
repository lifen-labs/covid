FactoryBot.define do
  factory :standard_survey do
    association           :patient

    body_temperature      { 37.2 }

    trait(:empty) do
      body_temperature                      { nil }
      cohabitants_recent_change             { nil }
      breathing_difficulty_borg_scale       { nil }
      heartbeats_per_minute                 { nil }
      recent_chest_pain                     { nil }
      agreed_containment                    { nil }
      agreed_containment_comment            { nil }
      respiratory_rate_in_cycles_per_minute { nil }
      recent_cold_chill                     { nil }
    end

    trait(:green) do
      completed_at                          { 1.day.ago }
      status                                { StandardSurvey::STATUS_GREEN }

      body_temperature                      { 38.4 }
      cohabitants_recent_change             { false }
      breathing_difficulty_borg_scale       { "0" }
      heartbeats_per_minute                 { 109 }
      recent_chest_pain                     { false }
      agreed_containment                    { true }
      respiratory_rate_in_cycles_per_minute { 21 }
      recent_cold_chill                     { false }
    end

    trait(:yellow) do
      completed_at                          { 1.day.ago }
      status                                { StandardSurvey::STATUS_YELLOW }
    end

    trait(:orange) do
      completed_at                          { 1.day.ago }
      status                                { StandardSurvey::STATUS_ORANGE }

      body_temperature                      { 41 }
    end

    trait(:red) do
      completed_at                          { 1.day.ago }
      status                                { StandardSurvey::STATUS_RED }

      breathing_difficulty_borg_scale       { "6" }
    end
  end
end
