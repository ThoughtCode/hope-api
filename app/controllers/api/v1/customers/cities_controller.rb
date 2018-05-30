class Api::V1::Customers::CitiesController < Api::V1::ApiController
  include Serializable
  def index
    cities = City.all
    set_response(
      200,
      'Ciudades listadas exitosamente',
      serialize_city(cities)
    )
  end
end
