class SendEmailCompletedJobWorker
  include Sidekiq::Worker

  def perform(agent_id, job_id)
  	agent = Agent.find(agent_id)
  	job = Job.find(job_id)
    CustomerMailer.send_job_completed(job.property.customer, job.hashed_id, ENV['FRONTEND_URL']).deliver
    AgentMailer.send_job_completed(agent, job.hashed_id, url).deliver
  end
end
