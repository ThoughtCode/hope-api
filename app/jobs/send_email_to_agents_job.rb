class SendEmailToAgentsJob < ApplicationJob
  queue_as :default

  def perform(job_id, url)
    job = Job.find_by(hashed_id: job_id)
    agents = Agent.filter_by_availability(job)
    agents.map do |agent|
      AgentMailer.send_email_to_agent(agent, job_id, url).deliver
      Notification.create(text: 'Hay un nuevo trabajo disponible', agent: agent, job_id: job_id)
    end
  end
end
