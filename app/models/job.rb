class Job < ApplicationRecord
  include Hashable
  belongs_to :agent, optional: true
  belongs_to :property
  has_many :job_details, dependent: :destroy
  has_many :services, through: :job_details
  has_many :proposals
  has_many :agents, through: :proposals
  has_many :reviews, dependent: :destroy
  has_many :penalties

  before_create :check_dates
  after_save :calculate_price
  after_create_commit :send_email_create_job

  enum status: %i[pending accepted cancelled completed]
  enum frequency: %i[one_time weekly fortnightly monthly]

  accepts_nested_attributes_for :job_details

  def set_job_to_cancelled
    cancel_booking
    self.status = 'cancelled'
    send_email_to_agent if agent
  end

  def send_email_to_agent
    AgentMailer.job_cancelled_email(agent).deliver
  end

  def cancel_booking
    amount = if Config.fetch('cancelation_penalty_amount')
               Config.fetch('cancelation_penalty_amount')
             else
               0
             end
    customer = property.customer
    Penalty.create!(amount: amount, customer: customer) unless can_cancel_booking?
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
    return nil if new_job.started_at > finished_recurrency_at
    new_job.save!
    send_email_autocreated_job(new_job)
  end

  def can_review?(user)
    reviews.where(owner: user).blank? && Time.now > started_at && (user == agent || user == property.customer)
  end

  def service_type_image
    image = job_details.select { |jd| jd.service.type_service == 'base' }.first
    image.service.service_type.image
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
    duration = job_details.pluck(:time).compact.sum
    total = job_details.pluck(:price_total).compact.sum
    total += (total * 0.12)
    finished_at = started_at + duration.hour
    update_columns(duration: duration, total: total, finished_at: finished_at)
  end

  def send_email_create_job
    SendEmailJobCreateJob.perform_later(self, property.customer, ENV['FRONTEND_URL'])
    SendEmailToAgentsJob.perform_later(hashed_id, ENV['FRONTEND_URL']) unless agent
  end
end
