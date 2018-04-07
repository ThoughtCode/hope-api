class Job < ApplicationRecord
  belongs_to :customer
  belongs_to :agent, optional: true
  belongs_to :property
  belongs_to :service
end
