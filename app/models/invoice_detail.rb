class InvoiceDetail < ApplicationRecord
  belongs_to :customer
  has_many :invoices
  enum identification_type: %i[consumidor_final cedula ruc]
end
