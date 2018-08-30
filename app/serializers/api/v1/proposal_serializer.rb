class Api::V1::ProposalSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :id, :job, :agent, :hashed_id

  # attribute :agent_rewiews_count do |j|
  #   j.agent&.my_qualifications&.count
  # end

  # attribute :agent_rewiews_average do |j|
  #   j.agent&.reviews_average
  # end



  attribute :agent do |j|
    unless j.agent.nil?
    {
        data: {
          id: j.agent.id,
          type: 'agent',
          attributes: {
            first_name: j.agent.first_name,
            last_name: j.agent.last_name,
            email: j.agent.email,
            access_token: j.agent.access_token,
            avatar: {
                url: j.agent.avatar.url
            },
            national_id: j.agent.national_id,
            cell_phone: j.agent.cell_phone,
            rewiews_count: j.agent.my_qualifications.count,
            rewiews_average: j.agent.reviews_average,
            jobs_count: j.agent.jobs.count,
            status: j.agent.status
          }
        }
      }
    end
  end
end
