class SendPaymentRequest < ApplicationJob
  queue_as :default

  def perform(payment, job)
    payment.send_payment_request
    Invoices.generate_for_penalty(job.invoice, payment, job)
  end
end
