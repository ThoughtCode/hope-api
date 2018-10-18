class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :property_id, :started_at, :finished_at, :duration,
             :status, :frequency, :property, :agent, :details, :finished_recurrency_at

  attribute :total do |object|
    object.total.to_f
  end

  attribute :vat do |object|
    object.vat.to_f
  end

  attribute :subtotal do |object|
    object.subtotal.to_f
  end

  attribute :service_fee do |object|
    object.service_fee.to_f
  end

  attribute :agent_earnings do |object|
    object.agent_earnings.to_f
  end

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
        data: reviews
      }
    end
  end

  attribute :job_details do |j|
    j.job_details.as_json(except: [:job_id], include: [:service])
  end

  attribute :service_type_image, &:service_type_image

  attribute :customer do |j|
    j.property.customer
  end

  attribute :property do |j|
    {
      data: {
        id: j.property.hashed_id,
        type: "property",
        attributes: {
          id: j.property.id,
          name: j.property.name,
          p_street: j.property.p_street,
          s_street: j.property.s_street,
          number: j.property.number,
          additional_reference: j.property.additional_reference,
          phone: j.property.phone,
          neightborhood_id: j.property.neightborhood_id,
          neightborhood: j.property.neightborhood,
          city_id: j.property.neightborhood.city_id,
          city: j.property.neightborhood.name,
          customer: {
            data: {
              id: j.property.customer.id, 
              type: 'customer',
              attributes: {
                first_name: j.property.customer.first_name,
                last_name: j.property.customer.last_name,
                email: j.property.customer.email,
                access_token: j.property.customer.access_token,
                avatar: {
                  url: j.property.customer.avatar.url,
                },
                national_id: j.property.customer.national_id,
                cell_phone: j.property.customer.cell_phone,
                hashed_id: j.property.customer.hashed_id,
                rewiews_count: j.property.customer.my_qualifications.count,
                rewiews_average: j.property.customer.reviews_average,
              }
            }
          }
        }
      }
    }
  end

  attribute :proposals do |j|
    Api::V1::ProposalSerializer.new(j.proposals)
  end
  
  attribute :config do |j|
    Config.all.as_json
  end

  attribute :can_cancel, &:can_cancel_booking?
end
