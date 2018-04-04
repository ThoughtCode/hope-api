class Api::V1::Customers::PropertiesController < Api::V1::ApiController
  def index
    properties = current_user.properties.all
    render status: 200, json: {
      properties: properties
    }
  end

  def create
    property = Property.new(property_params)
    property.customer = current_user
    if property.save
      render status: 200, json: {
        message: 'Property created'
      }
    else
      render json: {
        message: property.errors
      }
    end
  end

  private

  def property_params
    params
      .require(:property)
      .permit(:name, :neightborhood_id, :p_street, :number, :s_street, :details,
              :cell_phone)
  end
end
