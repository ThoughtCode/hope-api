class Api::V1::CustomerSerializer
  include FastJsonapi::ObjectSerializer
  set_type :customer # optional
  set_id :id # optional
  attributes :first_name, :last_name, :email, :access_token, :avatar,
             :national_id, :cell_phone, :birthday, :hashed_id

  attribute :rewiews_count do |c|
    c.my_qualifications.count
  end

  attribute :rewiews_average do |c|
    c.reviews_average
  end

  # attribute :rewiews do |c|
  #   c.my_qualifications
  # end

  attribute :rewiews do |c|
    Api::V1::ReviewSerializer.new(c.my_qualifications)
  end
end
