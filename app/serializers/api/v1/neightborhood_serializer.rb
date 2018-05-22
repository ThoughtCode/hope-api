class Api::V1::NeightborhoodSerializer
  include FastJsonapi::ObjectSerializer
  set_type :neightborhood # optional
  set_id :id # optional
  attributes :name
end
