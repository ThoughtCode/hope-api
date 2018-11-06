class Invoice < ApplicationRecord
  belongs_to :job
  belongs_to :customer
  belongs_to :invoice_detail
end
