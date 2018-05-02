class SendEmailToAgentsJob < ApplicationJob
  queue_as :default

  def perform(job_id, url)
    job = Job.find_by(hashed_id: job_id)
    agents = Agent.filter_by_availability(job)
    agents.map do |a|
      AgentMailer.send_email_to_agent(a, job_id, url).deliver
    end
  end
end
