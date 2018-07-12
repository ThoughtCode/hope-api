class SendEmailToCounterpartAgentJob < ApplicationJob
  queue_as :default

  def perform(job, agent, url)
    AgentMailer.send_email_review(job.hashed_id, agent, url).deliver
  end
end
