class SendEmailToCounterpartCustomerJob < ApplicationJob
  queue_as :default

  def perform(job, customer, url)
    CustomerMailer.send_email_review(job.hashed_id, customer, url).deliver
  end
end
