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
    amount = if Config.fetch('cancelation_penalty_amount')
               Config.fetch('cancelation_penalty_amount')
             else
               0
             end
    Penalty.create!(amount: amount, customer: property.customer) unless can_cancel_booking?
  end

  def can_cancel_booking?
    time = Config.fetch('cancelation_penalty_time')
    if Config.fetch('cancelation_penalty_time')
      ((started_at - Time.current) / 3600) >= time.to_i
    else
      true
    end
  end

  def job_recurrency
    new_job = dup
    new_job.status = 'accepted'
    job_details.each do |d|
      new_job.job_details << d.dup
    end
    case frequency
    when 'weekly'
      new_job.started_at = started_at + 7.days
    when 'fortnightly'
      new_job.started_at = started_at + 14.days
    when 'monthly'
      new_job.started_at = started_at + 28.days
    end
    new_job.save!
    send_email_autocreated_job(new_job)
  end

  private

  def send_email_autocreated_job(job)
    customer = job.property.customer
    url = ENV['FRONTEND_URL']
    CustomerMailer.send_job_recursivity(job, customer, url).deliver
  end

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
    total += (total * 0.12)
    finished_at = started_at + duration.hour
    update_columns(duration: duration, total: total, finished_at: finished_at)
  end

  def send_email_to_agents
    SendEmailToAgentsJob.perform_later(hashed_id, ENV['FRONTEND_URL']) unless agent
  end
end
