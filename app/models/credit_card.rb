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
  end
end

