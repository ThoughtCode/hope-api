class Neightborhood < ApplicationRecord
  belongs_to :city
  has_many :properties
end
