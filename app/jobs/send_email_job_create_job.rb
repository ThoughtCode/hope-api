class SendEmailJobCreateJob < ApplicationJob
  queue_as :default

  def perform(job, customer, url)
  end
end
