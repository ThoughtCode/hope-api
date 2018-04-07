class Service < ApplicationRecord
  belongs_to :service_type
  enum type_services: { base: 0, addon: 1 }
end
