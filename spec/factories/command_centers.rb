FactoryBot.define do
  factory :command_center do
    name { FFaker::Company.name }
    city { FFaker::AddressFR.city }
  end
end
