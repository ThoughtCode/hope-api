FactoryBot.define do
  factory :service do
    service_type
    type_service :base
    name 'Numero de cuartos'
    quantity true
    time 1
    price 100.00

    trait :addon do
      status :addon
    end
  end
end
