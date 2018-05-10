class Service < ApplicationRecord
  has_many :jobs
  has_many :job_details
  belongs_to :service_type
  enum type_service: %i[base addon]
end
