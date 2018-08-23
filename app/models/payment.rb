class Payment < ApplicationRecord
  belongs_to :job
  belongs_to :customer
  belongs_to :credit_card

  def send_payment_request
    connection = Faraday.new
    customer = self.customer
    body = '{ "user": {
         "id":"'+ customer.id.to_s + '",
         "email": "'+ "#{customer.email}" +'"
     },
     "order": {
         "amount": '+ self.job.total.to_s + ',
         "description": "' + "#{self.description} " +'",
         "dev_reference": "'+ self.id.to_s + '",
         "vat": 0.00
     },
     "card": {
         "token": "' + "#{self.credit_card.token }"+ '"
    }}'
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/transaction/debit/'
      req.body = body
    end
    # byebug
    Rails.logger.info(response.body)
    response = response.status
  end
end