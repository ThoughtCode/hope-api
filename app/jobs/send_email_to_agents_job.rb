class SendEmailToAgentsJob < ApplicationJob
  queue_as :default

  def perform(job_id, url)
    
  end
end
