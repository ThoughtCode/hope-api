class Customer < ApplicationRecord
  include Pinable
  include Reviewable
  include Tokenizable
  include Hashable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :properties, dependent: :destroy
  has_many :jobs, through: :properties
  has_many :reviews, as: :owner
  has_many :reviews, as: :reviewee
  has_many :penalties
  has_many :notifications
  has_many :credit_cards
  has_many :payments
  has_many :invoices
  has_many :invoice_details
  mount_uploader :avatar, AvatarUploader
  after_create :send_welcome_email

  def full_name
    "#{first_name} #{last_name}"
  end

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
