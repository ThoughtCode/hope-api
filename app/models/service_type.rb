class ServiceType < ApplicationRecord
  include Hashable
  has_many :services
end
