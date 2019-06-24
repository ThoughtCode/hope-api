class Payment < ApplicationRecord
  belongs_to :job
  belongs_to :customer
  belongs_to :credit_card

  def send_payment_request
    connection = Faraday.new
    installments_type = 0
    if job.installments == 0
      installments_type = 0
    end
    if job.installments == 3
      installments_type = 3
    end

    customer = self.customer
    body = '{ "user": {
         "id":"'+ customer.id.to_s + '",
         "email": "'+ "#{customer.email}" +'"
     },
     "order": {
         "amount": '+ self.amount.to_s + ',
         "description": "' + "#{self.description} " +'",
         "dev_reference": "'+ self.id.to_s + '",
         "vat": '+"#{self.vat.to_s}"+',
         "installments_type": '+ installments_type.to_s + ',
         "installments": '+"#{self.installments}"+'
     },
     "card": {
         "token": "' + "#{self.credit_card.token }"+ '"
    }}'
    Rails.logger.info(body)
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/transaction/debit/'
      req.body = body
    end
    Rails.logger.info(response.body)


    if response.body['error']["type"] = "OperationNotAllowedException:uid does not match"
      Rails.logger.info("existio error!!!!!")
    end


    response = response.status
  end

  def send_payment_request_as_null
    connection = Faraday.new
    installments_type = 0
    if job.installments == 0
      installments_type = 0
    end
    if job.installments == 3
      installments_type = 3
    end

    customer = self.customer
    body = '{ "user": {
         "id":"'+ 'null' + '",
         "email": "'+ "#{customer.email}" +'"
     },
     "order": {
         "amount": '+ self.amount.to_s + ',
         "description": "' + "#{self.description} " +'",
         "dev_reference": "'+ self.id.to_s + '",
         "vat": '+"#{self.vat.to_s}"+',
         "installments_type": '+ installments_type.to_s + ',
         "installments": '+"#{self.installments}"+'
     },
     "card": {
         "token": "' + "#{self.credit_card.token }"+ '"
    }}'
    Rails.logger.info(body)
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/transaction/debit/'
      req.body = body
    end
    Rails.logger.info(response.body)
    response = response.status
  end

  def refund
    connection = Faraday.new
    customer = self.customer
    body = '{ "transaction": {
        "id": "'+ "#{self.transaction_identifier}" +'"
    }}'
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/transaction/refund/'
      req.body = body
    end
    # byebug
    Rails.logger.info(response.body)
    response = response.status
  end

  def check_receipt_send
    if self.receipt_send == false  && self.status == 'Approved'
      if is_receipt_cancel
        CustomerMailer.send_receipt_cancelled(self.job, self.customer, self).deliver
      else
        CustomerMailer.send_receipt(self.job, self.customer, self).deliver
      end
      self.update_columns(receipt_send: true)
    end
  end
end
