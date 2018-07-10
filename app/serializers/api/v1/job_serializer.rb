class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id # optional
  attributes :property_id, :started_at, :finished_at, :duration, :total,
             :status, :frequency, :property, :agent

  attribute :agent_rewiews_count do |j|
    j.agent.my_qualifications.count unless j.agent.nil?
  end
  
  attribute :agent_rewiews_average do |j|
    j.agent.reviews_average unless j.agent.nil?
  end

  attribute :agent_rewiews do |j|
    Api::V1::ReviewSerializer.new(j.agent.my_qualifications) unless j.agent.nil?
  end

  attribute :job_details do |j|
    j.job_details.as_json(except: [:job_id], include: [:service])
  end

  attribute :customer do |j|
    j.property.customer
  end

  attribute :property do |j|
    Api::V1::PropertySerializer.new(j.property)
  end

  attribute :proposals do |j|
    Api::V1::ProposalSerializer.new(j.proposals)
  end

  attribute :can_cancel do |j|
    j.can_cancel_booking?
  end
end
