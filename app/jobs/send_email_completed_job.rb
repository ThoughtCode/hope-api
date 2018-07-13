class SendEmailCompletedJob < ApplicationJob
  queue_as :default

  def perform(agent, job, url)
    CustomerMailer.send_job_completed(job.property.customer, job.hashed_id, url).deliver
    AgentMailer.send_job_completed(agent, job.hashed_id, url).deliver
  end
end
