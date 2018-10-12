class SendPaymentRequest < ApplicationJob
  queue_as :default

  def perform(payment)
    payment.send_payment_request
  end
end
