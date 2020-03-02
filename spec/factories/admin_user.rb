FactoryBot.define do
  factory :admin_user do
    sequence(:email)  { |i| "email-##{i}@domain.fr" }
    password          { 'MotDePasse' }
  end
end
