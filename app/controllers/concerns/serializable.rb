module Serializable
  extend ActiveSupport::Concern

  def serialize_customer(customer)
    Api::V1::CustomerSerializer.new(customer).serialized_json
  end

  def serialize_agent(agent)
    Api::V1::AgentSerializer.new(agent).serialized_json
  end
end
