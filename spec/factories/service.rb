FactoryBot.define do
  factory :service do |s|
    s.service_type
    s.type_service 0
    s.name 'Numero de cuartos'
    s.quantity true
    s.time 1
    s.price 100.00
  end
end
