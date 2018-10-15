class InvoiceDetail < ApplicationRecord
  belongs_to :customer
  enum identification_type: %i[consumidor_final cedula ruc]
end
