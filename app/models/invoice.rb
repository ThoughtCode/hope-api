class Invoice < ApplicationRecord
  belongs_to :job
  belongs_to :customer
end
