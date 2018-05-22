class Api::V1::ServiceTypeSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :name

  attribute :service_base do |s|
    s.services.where(type_service: 'base')
  end

  attribute :services_addons do |s|
    s.services.where(type_service: 'addon')
  end
end
