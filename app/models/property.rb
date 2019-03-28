class Property < ApplicationRecord
  include Hashable
  belongs_to :customer
  belongs_to :neightborhood
  validates_presence_of :name, :neightborhood_id, :p_street, :number, :s_street
  has_many :jobs

  def full_property_name
    "#{p_street} #{number} #{s_street}, #{neightborhood.name}, #{neightborhood.city.name}"
  end
end