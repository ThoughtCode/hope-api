class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :property_id, :started_at, :finished_at, :duration, :total,
             :status, :frequency, :property, :agent, :details, :finished_recurrency_at

  attribute :agent_rewiews_count do |j|
    j.agent&.my_qualifications&.count
  end

  attribute :agent_rewiews_average do |j|
    j.agent&.reviews_average
  end

  attribute :agent_jobs_count do |j|
    j.agent&.agent_jobs_count
  end

  attribute :agent_rewiews do |j|
    Api::V1::ReviewSerializer.new(j.agent.my_qualifications) unless j.agent.nil?
  end

  attribute :job_details do |j|
    j.job_details.as_json(except: [:job_id], include: [:service])
  end

  attribute :service_type_image, &:service_type_image

  attribute :customer do |j|
    j.property.customer
  end

  attribute :property do |j|
    Api::V1::PropertySerializer.new(j.property)
  end

  attribute :proposals do |j|
    Api::V1::ProposalSerializer.new(j.proposals)
  end
  
  attribute :config do |j|
    Config.all.as_json
  end

  attribute :can_cancel, &:can_cancel_booking?
end
