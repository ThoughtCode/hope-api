FactoryBot.define do
  factory :property do |p|
    p.name { Faker::Company.name }
    p.p_street { Faker::Address.street_name }
    p.number { Faker::Address.building_number }
    p.s_street { Faker::Address.secondary_address }
    p.details { Faker::Address.street_address }
    p.cell_phone { '123456789' }
    p.customer
    p.neightborhood
  end
end
