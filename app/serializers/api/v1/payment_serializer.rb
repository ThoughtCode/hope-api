class Api::V1::PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :holder_name, :card_type, :number, :token, :status, :expiry_month, :expiry_year
end
