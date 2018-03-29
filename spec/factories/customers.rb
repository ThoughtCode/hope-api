FactoryBot.define do
  factory :customer do |c|
    c.email { Faker::Internet.email }
    c.password 'test1234'
    c.password_confirmation 'test1234'
    c.first_name { Faker::Name.first_name }
    c.last_name { Faker::Name.last_name }
  end
end
