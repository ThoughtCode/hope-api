class Api::V1::NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :text, :customer_id, :status, :agent_id
end
