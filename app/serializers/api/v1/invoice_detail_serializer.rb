class Api::V1::InvoiceDetailSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :identification, :identification_type, :social_reason, :address, :telephone 
end
