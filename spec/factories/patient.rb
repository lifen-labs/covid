FactoryBot.define do
  factory :patient do
    association                  :command_center
    first_name                   { FFaker::NameFR.first_name }
    last_name                    { FFaker::NameFR.last_name }
    cellphone_number             { "+33#{rand(6..7)}#{rand(0..99_999_999).to_s.rjust(8, '0')}" }
    otp_secret                   { ROTP::Base32.random }
    survey_periodicity_in_hours  { 24 }
  end
end
