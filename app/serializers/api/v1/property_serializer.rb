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

  # attribute :customer do |p|
  #   Api::V1::CustomerSerializer.new(p.customer)
  # end
end
