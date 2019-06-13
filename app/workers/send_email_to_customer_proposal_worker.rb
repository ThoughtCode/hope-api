class SendEmailToCustomerProposalWorker
  include Sidekiq::Worker

  def perform(job_id, customer_id)
  	job = Job.find(job_id)
  	customer = Customer.find(customer_id)
    CustomerMailer.send_proposal_received(job, customer, ENV['FRONTEND_URL']).deliver
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
        customer.mobile_push_token = nil
        customer.save
        Rails.logger.info("Rescued: #{e.inspect}")
      end
    end
  end
end
