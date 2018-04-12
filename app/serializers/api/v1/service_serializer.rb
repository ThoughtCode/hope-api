class Api::V1::ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :type_service, :quantity, :time, :price
end
