class Agent < ApplicationRecord
  include Tokenizable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :jobs
end
