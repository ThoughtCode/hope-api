class Api::V1::ReviewSerializer
  include FastJsonapi::ObjectSerializer
  set_type :review # optional
  set_id :hashed_id # optional
  attributes :id, :comment, :qualification
end
