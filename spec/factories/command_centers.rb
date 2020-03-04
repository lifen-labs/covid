FactoryBot.define do
  factory :command_center do
    name          { FFaker::Company.name }
    city          { FFaker::AddressFR.city }
    phone_number  { "04 76 76 76 76" }
  end
end
