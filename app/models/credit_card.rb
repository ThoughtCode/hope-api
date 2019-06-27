class CreditCard < ApplicationRecord
  belongs_to :customer
  # belongs_to :job, optional: true
  has_many :payments
  before_update :erase_from_paymentez, if: :will_save_change_to_deleted?
  before_destroy :erase_from_paymentez
  scope :not_deleted, -> { where.not(deleted: true) }

  def erase_from_paymentez
    if payments.where(status: 'Pending').any?
      errors.add(:base, "Esta tarjeta tiene pagos pendientes")
      pp 'Esta tarjeta tiene pagos pendientes'
      throw(:abort)
    end

    connection = Faraday.new
    body = '{"card": { "token": "' + self.token.to_s + '" }, "user": { "id": "' + self.customer_id.to_s + '" }}'
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/card/delete/'
      req.body = body
    end

    Rails.logger.info(response.body)
    response = response.status
    unless response == 200
      update_column(:deleted, false)
      errors.add(:base, "Error al borrar tarjeta")
      throw(:abort)
    end
  end

  def erase_from_paymentez_if_null(string)
    connection = Faraday.new
    body = '{"card": { "token": "' + self.token.to_s + '" }, "user": { "id": "' + string + '" }}'
    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + '/v2/card/delete/'
      req.body = body
    end
  end

  def self.card_list
    connection = Faraday.new
    body = '{}'
    (1..500).each do |index|
      response = connection.get do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Auth-Token'] = (PaymentToken.authorize)
        req.url ENV['PAYMENTEZ_URL'] + "/v2/card/list/?uid=#{index}"
        req.body = body
      end
      Rails.logger.info(response.body)
    end
    Rails.logger.info("************ FINAL SEARCH *********")
    response = connection.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + "/v2/card/list/?uid=null"
      req.body = body
    end
    Rails.logger.info(response.body)

    Rails.logger.info("************ FINAL SEARCH *********")
    response = connection.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + "/v2/card/list/?uid=undefined"
      req.body = body
    end

    Rails.logger.info(response.body)

    Rails.logger.info("************ FINAL SEARCH *********")
    response = connection.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Auth-Token'] = (PaymentToken.authorize)
      req.url ENV['PAYMENTEZ_URL'] + "/v2/card/list/?uid="
      req.body = body
    end

    Rails.logger.info(response.body)
  end


  def self.find_if_payment_pending_has_null
    connection = Faraday.new

    Payment.where(status:'Pending').each do |p| 
      response = connection.get do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Auth-Token'] = (PaymentToken.authorize)
        req.url ENV['PAYMENTEZ_URL'] + "/v2/card/list/?uid=#{p.customer.id}"
      end
      Rails.logger.info("Payment ID: #{p.id} -----> #{response.body}")
    end
  end

end

