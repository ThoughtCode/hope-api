class Property < ApplicationRecord
  include Hashable
  belongs_to :customer
  belongs_to :neightborhood
  validates_presence_of :name, :neightborhood_id, :p_street, :number, :s_street,
                        :details, :cell_phone
  has_many :jobs
end
