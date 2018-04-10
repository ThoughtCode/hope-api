class Api::V1::Customers::PropertiesController < Api::V1::ApiController
  include Serializable
  before_action :set_property, only: %i[show update destroy]

  def index
    properties = current_user.properties.all
    set_response(
      200,
      'Property successfully listed.',
      serialize_property(properties)
    )
  end

  def create
    property = Property.new(property_params)
    property.customer = current_user
    if property.save
      set_response(200, 'Property created', serialize_property(property))
    else
      set_response(422, property.errors)
    end
  end

  def update
    if @property
      if !check_ownership
        if @property.update(property_params)
          set_response(200, 'Updated property successfully',
                       serialize_property(@property))
        else
          set_response(:unprocessable_entity, @property.errors)
        end
      else
        set_response(404, 'Property does not exists.')
      end
    else
      set_response(404, 'Property does not exists.')
    end
  end

  def destroy
    if @property
      if !check_ownership
        @property.destroy
        set_response(:ok, 'Property was deleted successfully.')
      else
        set_response(404, 'Property does not exists.')
      end
    else
      set_response(404, 'Property does not exists.')
    end
  end

  def show
    if @property
      if !check_ownership
        set_response(:ok, 'Property found successfully.',
                     serialize_property(@property))
      else
        set_response(404, 'Property does not exists.')
      end
    else
      set_response(404, 'Property does not exist.')
    end
  end

  private

  def property_params
    params
      .require(:property)
      .permit(:name, :neightborhood_id, :p_street, :number, :s_street, :details,
              :cell_phone)
  end

  def set_property
    @property = Property.find_by(hashed_id: params[:id])
  end

  def check_ownership
    @property.customer != current_user
  end
end
