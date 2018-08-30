class Api::V1::NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :text, :customer_id, :status, :agent_id

  attribute :job do |n|
    {
      data: {
        id: n.job.hashed_id
      }
    }
  end





end
