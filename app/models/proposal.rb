class Proposal < ApplicationRecord
  include Hashable
  belongs_to :job
  belongs_to :agent
  before_save :check_job_availability
  after_create_commit :send_email_notify_to_customer, on: :create
  enum status: %i[pending accepted refused expired]
  scope :check_availability, lambda { |job, agent|
    Job.all.where(
      'finished_at >= ? AND started_at <= ? AND agent_id = ? AND status != ?',
      job.started_at,
      job.finished_at,
      agent.id,
      1
    )
  }

  def send_email_notify_to_customer
    url = ENV['FRONTEND_URL']
    customer = job.property.customer
    SendEmailToCustomerProposal.perform_later(job, customer, url)
  end

  def set_proposal_to_job
    job.update_columns(agent_id: agent.id, status: 'accepted')
    self.status = 'accepted'
    send_mailer_to_agent_accepted
    set_other_proposals_to_refused
    save
  end

  def send_mailer_to_agent_accepted
    url = ENV['FRONTEND_URL']
    AgentMailer.send_proposal_accepted(agent, job.hashed_id, url).deliver
  end

  def set_to_refused
    self.status = 'refused'
  end

  def set_other_proposals_to_refused
    job.proposals.where.not(id: id).update_all(status: 'refused')
  end

  def can_accept_agent
    jobs = Proposal.check_availability(job, agent)
    destroy unless jobs.empty?
    jobs.empty?
  end

  private

  def check_job_availability
    jobs = Proposal.check_availability(job, agent)
    unless jobs.empty?
      errors[:base] << 'No tiene disponibilidad para aceptar este trabajo'
    end
    throw :abort unless jobs.empty?
  end
end
