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

  def serialize_job_for_agents(job)
    Api::V1::JobForAgentsSerializer.new(job)
  end

  def serialize_service_type(service_type)
    Api::V1::ServiceTypeSerializer.new(service_type)
  end

  def serialize_service(service)
    Api::V1::ServiceSerializer.new(service)
  end

  def serialize_proposal(proposal)
    Api::V1::ProposalSerializer.new(proposal)
  end

  def serialize_proposal_for_agents(proposal)
    Api::V1::ProposalForAgentsSerializer.new(proposal)
  end
end
