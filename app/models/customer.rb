class Customer < ApplicationRecord
  include Tokenizable
  include Pinable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :properties
  has_many :jobs, through: :properties
  mount_uploader :avatar, AvatarUploader
  after_create :send_welcome_email

  def send_recover_password_email
    set_reset_password_pin!
    CustomerMailer.send_recover_password_app_email(self).deliver
  end

  private

  def send_welcome_email
    CustomerMailer.send_welcome_email(self).deliver
  end
end
