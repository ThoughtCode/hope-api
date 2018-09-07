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
         "amount": '+ self.job.total.to_s + ',
         "description": "' + "#{self.description} " +'",
         "dev_reference": "'+ self.id.to_s + '",
         "vat": '+"#{self.vat.to_s}"+',
         "installments": '+"#{self.installments.to_s}"+', 
         "installments_type": '+ installments_type.to_s + '
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
    if self.receipt_send == false
      CustomerMailer.send_receipt(self.job, self.customer, self).deliver
      self.update_columns(receipt_send: true)
    end 
  end
end


{ "user": {
  "id":"112",
  "email": "osalas@paymentez.com"
,
"order": {
  "amount": 29.4,
  "description": "Trabajo de limpieza NocNoc Payment_id:26 ",
  "dev_reference": "26",
  "vat": 3.15,
  "installments": 0, 
  "installments_type":0
},
"card": {
  "token": "3027574355610588062"
}}