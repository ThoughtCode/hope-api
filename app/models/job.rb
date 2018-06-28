class Job < ApplicationRecord
  include Hashable
  belongs_to :agent, optional: true
  belongs_to :property
  has_many :job_details, dependent: :destroy
  has_many :services, through: :job_details
  has_many :proposals
  has_many :reviews
  has_many :penalties

  before_create :check_dates
  after_save :calculate_price
  after_create_commit :send_email_to_agents

  enum status: %i[pending accepted cancelled expired completed]
  enum frequency: %i[one_time weekly fortnightly monthly]

  accepts_nested_attributes_for :job_details

  def set_job_to_cancelled
    cancel_booking
    self.status = 'cancelled'
  end

  def cancel_booking
    unless can_cancel_booking?
      amount = if Config.fetch('cancelation_penalty_amount')
                 Config.fetch('cancelation_penalty_amount')
               else
                 0
               end
      Penalty.create!(amount: amount, customer: cleaner)
    end
  end

  def can_cancel_booking?
    if Config.fetch('cancelation_penalty_time')
      ((started_at - Time.current) / 3600) >= Config.fetch('cancelation_penalty_time').to_i
    else
      true
    end
  end

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
