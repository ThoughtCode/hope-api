class Api::V1::Customers::ServiceTypesController < Api::V1::ApiController
  include Serializable
  def index
    services = ServiceType.all
    set_response(
      200,
      'Service types successfully listed.',
      serialize_service_type(services)
    )
  end
end
