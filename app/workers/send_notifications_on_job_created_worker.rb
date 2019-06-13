class SendNotificationsOnJobCreatedWorker
  include Sidekiq::Worker

  def perform(agent_id, hashed_id, job_id)
  	agent = Agent.find(agent_id)
    Notification.create(text: 'Existen trabajos disponibles, postula ahora', agent: agent, job_id: job_id)
    AgentMailer.send_email_to_agent(agent, hashed_id, ENV['FRONTEND_URL']).deliver
    if agent.mobile_push_token
      begin
        client = Exponent::Push::Client.new
        messages = [{
          to: "#{agent.mobile_push_token}",
          sound: "default",
          body: "Existen trabajos disponibles, postula ahora",
          ttl: 28800
        }]
        client.publish messages
      rescue StandardError => e
        agent.mobile_push_token = nil
        agent.save
        Rails.logger.info("Rescued: #{e.inspect}")
      end
    end
  end
end
