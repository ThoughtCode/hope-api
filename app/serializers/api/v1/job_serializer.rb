class Api::V1::JobSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status
end
