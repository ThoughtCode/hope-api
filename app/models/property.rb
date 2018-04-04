class Property < ApplicationRecord
  belongs_to :customer
  belongs_to :neightborhood
  validates_presence_of :name, :neightborhood_id, :p_street, :number, :s_street,
                        :details, :cell_phone

  include Hashable
end
