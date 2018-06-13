class Agent < ApplicationRecord
  include Tokenizable
  include Pinable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :jobs
  has_many :proposals
  enum status: %i[pending accepted refused]
  mount_uploader :avatar, AvatarUploader
  scope :filter_by_availability, lambda { |job|
    Agent.where.not(
      id: Job.where(
        'finished_at >= ? AND started_at <= ?', job.started_at, job.finished_at
      ).pluck(:agent_id),
      status: %i[pending refused],
      online: false
    )
  }

  def send_recover_password_email
    set_reset_password_pin!
    AgentMailer.send_recover_password_app_email(self).deliver
  end
end
