class Service < ApplicationRecord
  has_many :jobs
  has_many :job_details
  belongs_to :service_type
  has_many :promotions
  enum type_service: %i[base addon parameter]
end
