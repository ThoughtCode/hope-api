class SendEmailToCustomerProposal < ApplicationJob
  queue_as :default

  def perform(job, customer, url)
    CustomerMailer.send_proposal_received(job, customer, url).deliver
    Notification.create(text: 'Han recibido tu propuesta', customer: customer, job: job)
    if customer.mobile_push_token
      begin
        client = Exponent::Push::Client.new
        messages = [{
          to: "#{customer.mobile_push_token}",
          sound: "default",
          ttl: 28800,
          body: "#{job.agent.first_name} quiere trabajar para ti "
        }]
        client.publish messages
      rescue StandardError => e
        Rails.logger.info("Rescued: #{e.inspect}")
      end
    end
  end
end
