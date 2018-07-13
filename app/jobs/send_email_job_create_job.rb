class SendEmailJobCreateJob < ApplicationJob
  queue_as :default

  def perform(job, customer, url)
    CustomerMailer.send_email_create_job(job, customer, url).deliver
  end
end
