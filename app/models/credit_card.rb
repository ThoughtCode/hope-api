class CreditCard < ApplicationRecord
  belongs_to :customer
  before_destroy :erase_from_paymentez


  def erase_from_paymentez
    connection = Faraday.new
    body = '{"card": { "token": "' + self.token.to_s + '" }, "user": { "id": "' + self.customer_id.to_s + '" }}'
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/card/delete/'
      req.body = body
    end
    response = response.status
    unless response == 200
      errors.add(:base, "Error al borrar tarjeta")
      throw(:abort)
    end
  end
end
