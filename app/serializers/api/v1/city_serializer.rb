class Api::V1::CitySerializer
  include FastJsonapi::ObjectSerializer
  set_type :city # optional
  set_id :id # optional
  attributes :name
end
