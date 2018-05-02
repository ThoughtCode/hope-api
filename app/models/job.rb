class Job < ApplicationRecord
  include Hashable
  belongs_to :agent, optional: true
  belongs_to :property
  has_many :job_details, dependent: :destroy
  has_many :services, through: :job_details
  after_save :calculate_price
  after_create_commit :send_email_to_agents

  accepts_nested_attributes_for :job_details

  def check_dates?
    started_at >= Time.current
  end

  private

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
