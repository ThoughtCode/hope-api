class City < ApplicationRecord
  validates_presence_of :name, on: %i[create update]
  has_many :neightborhoods
  accepts_nested_attributes_for :neightborhoods, allow_destroy: true
end
