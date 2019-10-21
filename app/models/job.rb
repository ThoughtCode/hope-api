class Job < ApplicationRecord
  include Hashable
  belongs_to :agent, optional: true
  belongs_to :property
  belongs_to :promotion
  has_many :job_details, dependent: :destroy
  has_many :services, through: :job_details
  has_many :notifications, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :agents, through: :proposals
  has_many :reviews, dependent: :destroy
  has_many :penalties
  # has_one :credit_card
  has_one :payment
  has_one :invoice

  before_create :check_dates
  before_save :should_release_payment
  after_save :calculate_price
  after_create_commit :send_email_create_job

  enum status: %i[pending accepted cancelled completed]
  enum frequency: %i[one_time weekly fortnightly monthly]
  enum source: %i[web app]

  accepts_nested_attributes_for :job_details, allow_destroy: true

  def set_job_to_cancelled
    cancel_booking
    self.status = 'cancelled'
    send_email_to_agent if agent
    agent = self.agent
    if !agent.nil?
      Notification.create(text: 'El trabajo al que aplicaste fue cancelado', agent: agent, job: self)
      if agent.mobile_push_token
        begin
          client = Exponent::Push::Client.new
          messages = [{
            to: "#{agent.mobile_push_token}",
            sound: "default",
            body: "El trabajo al que aplicaste fue cancelado"
          }]
          client.publish messages
        rescue StandardError => e
          agent.mobile_push_token = nil
          agent.save
          Rails.logger.info("Rescued: #{e.inspect}")
        end
      end
    end
  end

  def send_email_to_agent
    AgentMailer.job_cancelled_email(agent).deliver
  end

  def cancel_booking
    unless can_cancel_booking?
      penalty_amount = Config.fetch('cancelation_penalty_amount')
      customer = property.customer
      Penalty.create!(amount: penalty_amount, customer: customer)
      payment.status = 'Cancelled'
      payment.save
      payment_cancelation_fee(payment.credit_card)
    end
  end

  def payment_cancelation_fee(credit_card)
    penalty_amount = Config.fetch('cancelation_penalty_amount')
    vat = ((penalty_amount.to_f * 12) / 100).round(2)
    payment = Payment.create(credit_card_id: payment.credit_card_id, amount: penalty_amount, vat: vat, status: 'Pending', 
      installments: 1, customer: self.property.customer, is_receipt_cancel: true, job: self)
    payment.description = "Multa de cancelación NocNoc Job Id:#{self.id}"
    payment.save
    SendPaymentRequestWorker.perform_async(payment.id, self.id)
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
    if new_job.save
      new_job.payment = Payment.create(credit_card_id: payment.credit_card_id, amount: total, status: 'Pending', 
      customer: self.property.customer, job: self, vat: vat, installments: installments)
      new_job.payment.description = "Trabajo de limpieza NocNoc Payment_id:#{new_job.payment.id}"
      new_job.payment.save!
      Invoice.create!(customer: self.property.customer, job: new_job, invoice_detail_id: self.invoice.invoice_detail_id)
      send_email_autocreated_job(new_job)
    end
    
  end

  def can_review?(user)
    reviews.where(owner: user).blank? && Time.now > started_at && (user == agent || user == property.customer)
  end

  def service_type_image
    image = job_details.select { |jd| jd.service.type_service == 'base' }.first
    image&.service&.service_type&.image
  end

  def self.should_be_reviewed
    jobs = Job.where('finished_at <= ? and review_notification_send = ? and status != ?', Time.current - 5.hours, false, 3)
    url = ENV['FRONTEND_URL']
    jobs.each do |j|
      # Enviar a agentes
      if j.agent
        Notification.create(text: 'Un trabajo a terminado por favor califícalo', agent: j.agent, job: j)
        AgentMailer.send_review_reminder(j.agent, j.hashed_id, url).deliver
        if j.agent.mobile_push_token
          begin
            client = Exponent::Push::Client.new
            messages = [{
              to: "#{j.agent.mobile_push_token}",
              ttl: 28800,
              sound: "default",
              body: "Un trabajo a terminado por favor califícalo"
            }]
            client.publish messages
          rescue StandardError => e
            j.agent.mobile_push_token = nil
            j.agent.save
            Rails.logger.info("Rescued: #{e.inspect}")
          end
        end
      # Enviar a clientes
        Notification.create(text: "#{j.agent.first_name} finalizó tú trabajo con éxito, por favor califícalo", customer: j.property.customer, job: j)
        CustomerMailer.send_review_reminder(j.hashed_id, j.property.customer, url).deliver
        j.update_columns(review_notification_send: true)
        if j.property.customer.mobile_push_token
          begin
            client = Exponent::Push::Client.new
            messages = [{
              to: "#{j.property.customer.mobile_push_token}",
              sound: "default",
              ttl: 28800,
              body: "#{j.agent.first_name} finalizó tú trabajo con éxito, por favor califícalo"
            }]
            client.publish messages
          rescue StandardError => e
            j.property.customer.mobile_push_token = nil
            j.property.customer.save
            Rails.logger.info("Rescued: #{e.inspect}")
          end
        end
      end
    end
  end

  def is_holiday?(date)
    return true if date.to_date.saturday?
    return true if date.to_date.sunday?
    Holiday.all.each do |holiday|
      return true if date.to_date == holiday.holiday_date.to_date
    end
    return false
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
    # Check if it is holiday or weekend
    overcharge = is_holiday?(started_at) ?  (1 + (Config.fetch('extra_service_fee_holiday').to_f/100)) : 1
    duration = job_details.pluck(:time).compact.sum
    discount = 0
    if promotion
      service = services.find(promotion.service_id)
      total_service = service.time * service.price
      discount = total_service * promotion.discount / 100
    end
    total = (job_details.pluck(:price_total).compact.sum * overcharge).round(2)
    total = total - discount
    service_fee = total * (Config.fetch('noc_noc_service_fee').to_f / 100)
    vat = (total * 0.12).round(2)
    sub_total = total
    agent_earnings = sub_total - service_fee
    total = total + vat
    finished_at = started_at + duration.hours
    update_columns(duration: duration, total: total, finished_at: finished_at, vat: vat, 
      subtotal: sub_total, service_fee: service_fee, agent_earnings: agent_earnings)
  end

  def should_release_payment
    if self.closed_by_agent && self.payment_started == false
      Rails.logger.info('*********************************************************************************************************************************************')
      Rails.logger.info('*********************************************************************************************************************************************') 
      Rails.logger.info('*********************************************************************************************************************************************')

      Rails.logger.info('Pago procesado')
      Rails.logger.info(self)

      Rails.logger.info('*********************************************************************************************************************************************')
      Rails.logger.info('*********************************************************************************************************************************************')
      Rails.logger.info('*********************************************************************************************************************************************')
      self.update_columns(payment_started: true)
      self.payment.send_payment_request
      Invoices.generate_for_job(self.invoice, self.payment, self)
    elsif self.closed_by_agent == false
      self.update_columns(status: 'cancelled')
    else
      # Do nothing
    end
  end

  def send_email_create_job
    CustomerMailer.send_email_create_job(self, property.customer, ENV['FRONTEND_URL']).deliver
    unless agent
      agents = Agent.filter_by_availability(self)
      agents.map do |agent|
        SendNotificationsOnJobCreatedWorker.perform_async(agent.id, self.hashed_id, self.id)
      end
    end
  end
end
