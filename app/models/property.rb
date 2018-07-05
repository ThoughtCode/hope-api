class Property < ApplicationRecord
  include Hashable
  belongs_to :customer
  belongs_to :neightborhood
  validates_presence_of :name, :neightborhood_id, :p_street, :number, :s_street
  has_many :jobs
end
