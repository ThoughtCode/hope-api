FactoryBot.define do
  factory :neightborhood do |p|
    p.name { Faker::Company.name }
    p.city
  end
end
