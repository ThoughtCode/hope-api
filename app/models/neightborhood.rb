class Neightborhood < ApplicationRecord
  validates_presence_of :name, on: %i[create update]
  belongs_to :city
  has_many :properties
end
