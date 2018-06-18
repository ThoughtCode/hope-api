module Api::V1::Customers
  class ServicesController < CustomerUsersController
    include Serializable
    def index
      service_type = ServiceType.find(params[:service_type_id])
      services = service_type.services
      set_response(
        200,
        'Services successfully listed.',
        serialize_service(services)
      )
    end
  end
end
