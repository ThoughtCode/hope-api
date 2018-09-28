class Review < ApplicationRecord
  include Hashable
  belongs_to :job
  belongs_to :owner, polymorphic: true
  belongs_to :reviewee, polymorphic: true


  after_create :complete_job
  after_create :send_counterpart_email

  validates_presence_of :comment, :qualification, :job
  validate :can_create

  private

  def can_create
    already_reviewed = job.reviews.find_by(owner: owner).blank?
    msg = 'ya calificado por usted'
    errors.add(:job, msg) unless already_reviewed
    msg = 'no puede recibir reviews aún, usted debe esperar '\
          'hasta después de la fecha contratada'
    errors.add(:job, msg) unless Time.now > job.started_at
  end

  def send_counterpart_email
    url = ENV['FRONTEND_URL']
    if owner.class.name == 'Agent'
      customer = job.property.customer
      CustomerMailer.send_email_review(job.hashed_id, customer, url).deliver
      Notification.create(text: 'Te han calificado!', customer: customer, job: job)
    else
      agent = job.agent
      AgentMailer.send_email_review(job.hashed_id, agent, url).deliver
      Notification.create(text: 'Te han calificado!', agent: agent, job: job)
    end
  end

  def complete_job
    return nil if owner.class.name == 'Customer' || job.reviews.none?
    job.completed!
    url = ENV['FRONTEND_URL']
    SendEmailCompletedJob.perform_later(owner, job, url)
  end
end
