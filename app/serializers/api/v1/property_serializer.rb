class Api::V1::PropertySerializer
  include FastJsonapi::ObjectSerializer
  set_id :hashed_id
  attributes :id, :name, :p_street, :number, :s_street,
             :additional_reference, :phone
  
  attribute :neightborhood_id do |n|
    n.neightborhood.id
  end
  
  attribute :neightborhood do |n|
    n.neightborhood.name
  end
  
  attribute :city_id do |n|
    n.neightborhood.city.id
  end
  
  attribute :city do |n|
    n.neightborhood.city.name
  end

  attribute :customer do |j|
    {
      data: {
        id: j.customer.id, 
        type: 'customer',
        attributes: {
          first_name: j.customer.first_name,
          last_name: j.customer.last_name,
          email: j.customer.email,
          access_token: j.customer.access_token,
          avatar: {
            url: j.customer.avatar.url,
          },
          national_id: j.customer.national_id,
          cell_phone: j.customer.cell_phone,
          hashed_id: j.customer.hashed_id,
          rewiews_count: j.customer.my_qualifications.count,
          rewiews_average: j.customer.reviews_average,
        }
      }
    }
  end
end
