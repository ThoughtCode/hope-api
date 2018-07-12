class SendEmailCompletedJob < ApplicationJob
  queue_as :default

  def perform(agent, customer, url)
    CustomerMailer.send_job_completed(customer, job.hashed_id, url).deliver
    AgentMailer.send_job_completed(agent, job.hashed_id, url).deliver
  end
end
