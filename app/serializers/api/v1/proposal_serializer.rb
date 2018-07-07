class Api::V1::ProposalSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :id, :job, :agent

  attribute :agent_rewiews_count do |j|
    j.agent.reviews.count unless j.agent.nil?
  end
  
  attribute :agent_rewiews_average do |j|
    j.agent.reviews_average unless j.agent.nil?
  end

  attribute :agent_rewiews do |j|
    j.agent.reviews unless j.agent.nil?
  end

end
