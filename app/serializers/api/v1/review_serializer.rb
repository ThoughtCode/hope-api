class Api::V1::ReviewSerializer
  include FastJsonapi::ObjectSerializer
  set_type :review # optional
  set_id :hashed_id # optional
  attributes :id, :comment, :qualification

  attribute :owner do |j|
    {
      data: {
      id: 3,
      type: "customer",
      attributes: {
        first_name: j.owner.first_name,
        last_name: j.owner.last_name,
        email: j.owner.email,
        access_token: j.owner.email,
        avatar: {
            url: j.owner.avatar.url,
        },
        national_id: j.owner.national_id,
        cell_phone: j.owner.cell_phone,
        hashed_id: j.owner.hashed_id,
        rewiews_count: j.owner.my_qualifications.count,
        rewiews_average: j.owner&.reviews_average
        }
      }
    }
  end
end
