module Api::V1::Customers
  class CitiesController < CustomerUsersController
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
end
