class Service < ApplicationRecord
  validates_inclusion_of :type_service, in: 0..1
  has_many :jobs
  has_many :job_details
  belongs_to :service_type
  enum type_services: { base: 0, addon: 1 }
end
