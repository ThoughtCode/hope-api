class SendPaymentRequestWorker
  include Sidekiq::Worker

  def perform(payment_id, job_id)
  	payment = Payment.find(payment_id)
  	job = Job.find(job_id)
    payment.send_payment_request
    Invoices.generate_for_penalty(job.invoice, payment, job)
  end
end
