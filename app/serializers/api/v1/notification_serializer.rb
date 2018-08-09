class Api::V1::NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :text, :customer_id, :status, :agent_id

  attribute :job do |j|
    Api::V1::JobSerializer.new(j)
  end
end
