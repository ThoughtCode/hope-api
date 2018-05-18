class Api::V1::ServiceTypeSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :name

  attribute :services do |s|
    s.services.as_json
  end
end
