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
    # Api::V1::AgentSerializer.new(j.agent) unless j.agent.nil?
 

    unless j.agent.nil?

    reviews = j.agent.my_qualifications.map do |c|
      { 
        id: c.hashed_id,
        type: 'review',
        attributes: {
          id: c.id,
          comment: c.comment,
          qualification: c.qualification,
          owner: {
            data: {
              id: c.owner.id,
              type: 'customer',
              attributes: {
                first_name: c.owner.first_name,
                last_name: c.owner.last_name,
                email: c.owner.email,
                access_token: c.owner.access_token,
                avatar: {
                  url: c.owner.avatar.url,
                },
                national_id: c.owner.national_id,
                cell_phone: c.owner.cell_phone,
                hashed_id: c.owner.hashed_id,
                rewiews_count: c.owner.my_qualifications.count,
                rewiews_average: c.owner&.reviews_average
              }
            }
          }
        }
      }
    end

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
          status: j.agent.status,
          rewiews:    {
            data: reviews
          }
        }
      }
      }
    end
  end
end

