class Api::V1::NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :text, :customer_id, :status, :agent_id

  attribute :job do |n|
    Api::V1::JobSerializer.new(n.job)
  end
end
