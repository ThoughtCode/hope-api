class City < ApplicationRecord
  has_many :neightborhoods
  accepts_nested_attributes_for :neightborhoods
end
