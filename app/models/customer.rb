class Customer < ApplicationRecord
  include Tokenizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :properties
  has_many :jobs, through: :properties
  mount_uploader :avatar, AvatarUploader
end
