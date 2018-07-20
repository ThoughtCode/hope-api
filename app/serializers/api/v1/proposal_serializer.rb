class Api::V1::ProposalSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :id, :job, :agent, :hashed_id

  attribute :agent_rewiews_count do |j|
    j.agent&.my_qualifications&.count
  end

  attribute :agent_rewiews_average do |j|
    j.agent&.reviews_average
  end

  attribute :agent_rewiews do |j|
    j.agent&.reviews
  end

  attribute :agent do |j|
    Api::V1::AgentSerializer.new(j.agent) unless j.agent.nil?
  end
end
