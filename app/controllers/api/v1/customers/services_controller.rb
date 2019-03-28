module Api::V1::Customers
  class ServicesController < CustomerUsersController
    include Serializable
    def index
      service_type = ServiceType.find(params[:service_type_id])
      services = service_type.services.order('id ASC')
      set_response(
        200,
        'Servicios listados.',
        serialize_service(services)
      )
    end
  end
end
