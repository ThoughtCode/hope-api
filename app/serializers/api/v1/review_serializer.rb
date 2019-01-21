class Api::V1::ReviewSerializer
  include FastJsonapi::ObjectSerializer
  set_type :review # optional
  set_id :hashed_id # optional
  attributes :id, :comment, :qualification

  attribute :rewiews_count do |a|
    a.my_qualifications.count
  end

  attribute :rewiews_average, &:reviews_average

  attribute :my_reviews do |j|
    {
      data: 
      {
        id: j.id,
        type: "review",
        attributes: {
          owner_first_name: j.owner.first_name,
          owner_last_name: j.owner.last_name,
          owner_email: j.owner.email,
          owner_avatar: {
              url: j.owner.avatar.url,
          },
          reviewee_first_name: j.reviewee.first_name,
          reviewee_last_name: j.reviewee.last_name,
          reviewee_email: j.reviewee.email,
          reviewee_avatar: {
              url: j.reviewee.avatar.url,
          },
        }
      }
    }
  end
end
