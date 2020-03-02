FactoryBot.define do
  factory :patient do
    first_name                   { FFaker::NameFR.first_name }
    last_name                    { FFaker::NameFR.last_name }
    cellphone_number             { "+33#{rand(6..7)}#{rand(0..99_999_999).to_s.rjust(8, '0')}" }
  end
end
