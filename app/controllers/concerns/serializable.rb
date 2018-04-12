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

  def serialize_job(job)
    Api::V1::JobSerializer.new(job)
  end

  def serialize_service_type(service_type)
    Api::V1::ServiceTypeSerializer.new(service_type)
  end

  def serialize_service(service)
    Api::V1::ServiceSerializer.new(service)
  end
end
