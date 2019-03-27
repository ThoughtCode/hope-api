module Api::V1::Customers
  class ServiceTypesController < CustomerUsersController
    include Serializable
    before_action :set_service, only: %i[show]
    def index
      services = ServiceType.all.order('id ASC')
      set_response(
        200,
        'Tipos de servicios listados',
        serialize_service_type(services)
      )
    end

    def show
      if @service
        set_response(
          200,
          'Servicios listados exitosamente',
          serialize_service_type(@service)
        )
      else
        set_response(
          404,
          'Servicio no encontrado'
        )
      end
    end

    private

    def set_service
      @service = ServiceType.find_by(hashed_id: params[:id])
    end
  end
end
