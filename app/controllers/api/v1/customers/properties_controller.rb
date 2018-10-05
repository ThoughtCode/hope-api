module Api::V1::Customers
  class PropertiesController < CustomerUsersController
    include Serializable
    before_action :set_property, only: %i[show update destroy]

    def index
      properties = current_user.properties.where(deleted: false)
      set_response(
        200,
        'Propiedades listadas',
        serialize_property(properties)
      )
    end

    def create
      property = Property.new(property_params)
      property.customer = current_user
      if property.save
        set_response(200, 'Propiedad creada exitosamente', serialize_property(property))
      else
        set_response(422, property.errors.messages.values.join(', '))
      end
    end

    def update
      if @property
        if !check_ownership
          if @property.update(property_params)
            set_response(200, 'Propiedad actualizada exitosamente',
                         serialize_property(@property))
          else
            set_response(422, @property.errors.messages.values.join(', '))
          end
        else
          set_response(404, 'La propiedad no existe')
        end
      else
        set_response(404, 'La propiedad no existe')
      end
    end

    def destroy
      if @property
        if !check_ownership
          @property.update_columns(deleted: true)
          set_response(200, 'La propiedad fue eliminada exitosamente')
        else
          set_response(404, 'La propiedad no existe')
        end
      else
        set_response(404, 'La propiedad no existe')
      end
    end

    def show
      if @property
        if !check_ownership
          set_response(200, 'Propiedad encontrada exitosamente',
                       serialize_property(@property))
        else
          set_response(404, 'La propiedad no existe')
        end
      else
        set_response(404, 'Property does not exist.')
      end
    end

    private

    def property_params
      params
        .require(:property)
        .permit(:name, :neightborhood_id, :p_street, :number, :s_street,
                :additional_reference, :phone)
    end

    def set_property
      @property = Property.find_by(hashed_id: params[:id])
    end

    def check_ownership
      @property.customer != current_user
    end
  end
end
