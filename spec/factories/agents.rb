FactoryBot.define do
  factory :agent do |a|
    a.email { Faker::Internet.email }
    a.password 'test1234'
    a.password_confirmation 'test1234'
    a.first_name { Faker::Name.first_name }
    a.last_name { Faker::Name.last_name }
    a.birthday { Faker::Date.birthday(18, 65) }
    a.status :accepted
    a.online true

    trait :offline do
      online false
    end

    trait :refused do
      status :refused
    end

    trait :pending do
      status :pending
    end
  end
end
