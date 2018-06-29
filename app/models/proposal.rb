class Proposal < ApplicationRecord
  include Hashable
  belongs_to :job
  belongs_to :agent
  # before_save :check_job_availability
  after_create_commit :send_email_notify_to_customer, on: :create
  enum status: %i[pending accepted refused expired]

  def send_email_notify_to_customer
    url = ENV['FRONTEND_URL']
    customer = job.property.customer
    CustomerMailer.send_proposal_received(self, customer, url).deliver
  end

  def set_proposal_to_job
    job.update_columns(agent_id: agent.id, status: 'accepted')
    self.status = 'accepted'
    set_other_proposals_to_refused
  end

  def set_to_refused
    self.status = 'refused'
  end

  def set_other_proposals_to_refused
    job.proposals.where.not(id: id).update_all(status: 'refused')
  end

  private

  def check_job_availability
    agents = Agent.filter_by_availability(job)
    unless agents.exists?(id: agent.id)
      errors.add(
        :agent, message: 'No tiene disponibilidad para aceptar este trabajo'
      )
    end
    throw :abort unless agents.exists?(id: agent.id)
  end
end
