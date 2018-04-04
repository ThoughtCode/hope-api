module Serializable
  extend ActiveSupport::Concern

  def serialize_customer(customer)
    Api::V1::CustomerSerializer.new(customer)
  end

  def serialize_agent(agent)
    Api::V1::AgentSerializer.new(agent)
  end

  def serialize_property(property)
    Api::V1::PropertySerializer.new(property)
  end
end
