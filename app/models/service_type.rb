class ServiceType < ApplicationRecord
  include Hashable
  has_many :services
  mount_uploader :image, ImageUploader
end
