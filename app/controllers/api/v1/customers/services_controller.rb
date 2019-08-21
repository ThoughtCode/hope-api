module Api::V1::Customers
  class ServicesController < CustomerUsersController
    include Serializable
    skip_before_action :disable_access_by_tk, only: [:index]
    def index
      service_type = ServiceType.find(params[:service_type_id])
      services = service_type.services.order('id DESC')
      set_response(
        200,
        'Servicios listados.',
        serialize_service(services)
      )
    end
  end
end
