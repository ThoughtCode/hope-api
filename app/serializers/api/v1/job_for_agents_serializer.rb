class Api::V1::JobForAgentsSerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :id, :property_id, :started_at, :finished_at, :duration, :total,
             :status, :details

  attribute :customer_rewiews_count do |j|
    j.property.customer&.my_qualifications&.count
  end

  attribute :customer_rewiews_average do |j|
    j.property.customer&.reviews_average
  end

  attribute :customer_rewiews do |j|
    Api::V1::ReviewSerializer.new(j.property.customer.my_qualifications)
  end

  attribute :job_details do |j|
    j.job_details.as_json(except: [:job_id], include: [:service])
  end

  attribute :customer do |j|
    Api::V1::CustomerSerializer.new(j.property.customer)
  end

end
