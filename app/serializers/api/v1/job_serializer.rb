class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :property_id, :started_at, :finished_at, :duration, :total, :vat, :subtotal,
             :status, :frequency, :property, :agent, :details, :finished_recurrency_at, :service_fee

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
    {
      data: {
        id: j.property.hashed_id,
        type: "property",
        attributes: {
          id: j.property.id,
          name: j.property.name,
          p_street: j.property.p_street,
          number: j.property.number,
          additional_reference: j.property.additional_reference,
          phone: j.property.phone,
          neightborhood_id: j.property.neightborhood_id,
          neightborhood: j.property.neightborhood,
          city_id: j.property.neightborhood.city_id,
          city: j.property.neightborhood.city,
          # customer: {
          #   data: {
          #     id: j.property.customer.id, 
          #     type: 'customer',
          #     attributes: {
          #       first_name: j.property.customer.first_name,
          #       last_name: j.property.customer.last_name,
          #       email: j.property.customer.email,
          #       access_token: j.property.customer.access_token,
          #       avatar: {
          #         url: j.property.customer.avatar.url,
          #       },
          #       national_id: j.property.customer.national_id,
          #       cell_phone: j.property.customer.cell_phone,
          #       hashed_id: j.property.customer.hashed_id,
          #       rewiews_count: j.property.customer.my_qualifications.count,
          #       rewiews_average: j.property.customer.reviews_average,
          #     }
          #   }
          # }
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
