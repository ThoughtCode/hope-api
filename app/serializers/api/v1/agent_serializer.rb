class Api::V1::AgentSerializer
  include FastJsonapi::ObjectSerializer
  set_type :agent # optional
  set_id :id # optional
  attributes :first_name, :last_name, :email, :access_token
end
