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
    a.my_qualifications
  end

  attribute :status
end
