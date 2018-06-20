class Job < ApplicationRecord
  include Hashable
  belongs_to :agent, optional: true
  belongs_to :property
  has_many :job_details, dependent: :destroy
  has_many :services, through: :job_details
  has_many :proposals
  has_many :reviews

  before_create :check_dates
  after_save :calculate_price
  after_create_commit :send_email_to_agents

  enum status: %i[pending accepted cancelled expired completed]
  enum frequency: %i[one_time weekly fortnightly monthly]

  accepts_nested_attributes_for :job_details

  private

  def check_dates
    if started_at <= Time.current
      errors.add(:base, 'La fecha de inicio no puede ser menor a la '\
          'fecha de hoy')
    end
    throw :abort if started_at <= Time.current
  end

  def calculate_price
    duration = job_details.sum(:time)
    total = job_details.sum(:price_total)
    finished_at = started_at + duration.hour
    update_columns(duration: duration, total: total, finished_at: finished_at)
  end

  def send_email_to_agents
    SendEmailToAgentsJob.perform_later(hashed_id, ENV['FRONTEND_URL'])
  end
end
