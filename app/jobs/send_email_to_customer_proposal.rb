class SendEmailToCustomerProposal < ApplicationJob
  queue_as :default

  def perform(job, customer, url)
    CustomerMailer.send_proposal_received(job, customer, url).deliver
    Notification.create(text: 'Propuesta recibida', customer: customer, job: job)
  end
end
