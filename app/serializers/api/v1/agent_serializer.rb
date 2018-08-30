class Api::V1::AgentSerializer
  include FastJsonapi::ObjectSerializer
  set_type :agent # optional
  set_id :id # optional
  attributes :first_name, :last_name, :email, :access_token, :avatar,
             :national_id, :cell_phone
  
  attribute :rewiews_count do |a|
    a.my_qualifications.count
  end

  attribute :rewiews_average, &:reviews_average

  attribute :jobs_count do |a|
    a.jobs.completed.count
  end

  attribute :rewiews do |a|
    reviews = a.reviews.map do |c|
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
      data: reviews
    }
  end

  attribute :status
end
