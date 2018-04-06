FactoryBot.define do
  factory :city do |p|
    p.name { Faker::Company.name }
  end
end
