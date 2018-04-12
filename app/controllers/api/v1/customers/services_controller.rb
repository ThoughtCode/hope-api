class Api::V1::Customers::ServicesController < Api::V1::ApiController
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
