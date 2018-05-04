class Agent < ApplicationRecord
  include Tokenizable
  include Pinable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :jobs

  def send_recover_password_email
    set_reset_password_pin!
    AgentMailer.send_recover_password_app_email(self).deliver
  end
end
