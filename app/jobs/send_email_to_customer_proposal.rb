class SendEmailToCustomerProposal < ApplicationJob
  queue_as :default

  def perform(job, customer, url)
    CustomerMailer.send_proposal_received(job, customer, url).deliver
    Notification.create(text: 'Han recibido tu propuesta', customer: customer, job: job)
    # if customer.mobile_push_token
    #   client = Exponent::Push::Client.new
    #   messages = [{
    #     to: "#{customer.mobile_push_token}",
    #     sound: "default",
    #     body: "Han recibido tu propuesta"
    #   }]
    #   client.publish messages
    # end
  end
end
