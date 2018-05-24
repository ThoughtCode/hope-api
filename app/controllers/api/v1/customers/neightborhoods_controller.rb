class Api::V1::Customers::NeightborhoodsController < Api::V1::ApiController
  include Serializable
  before_action :set_city

  def index
    neightborhoods = @city.neightborhoods
    set_response(
      200,
      'Barrios listados exitosamente',
      serialize_neightborhood(neightborhoods)
    )
  end

  private

  def set_city
    @city = City.find(params[:city_id])
  end
end
