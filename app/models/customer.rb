class Customer < ApplicationRecord
  include Pinable
  include Reviewable
  include Tokenizable
  include Hashable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :properties
  has_many :jobs, through: :properties
  has_many :reviews, as: :owner
  has_many :penalties
  mount_uploader :avatar, AvatarUploader
  after_create :send_welcome_email

  def send_recover_password_email
    set_reset_password_pin!
    CustomerMailer.send_recover_password_app_email(self).deliver
  end

  def get_review(job)
    Review.where.not(id: job.reviews.where(owner: self).pluck(:id))
  end

  private

  def send_welcome_email
    CustomerMailer.send_welcome_email(self).deliver
  end
end
