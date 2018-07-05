class JobDetail < ApplicationRecord
  belongs_to :job
  belongs_to :service
  after_save :calculate_price

  private

  def calculate_price
    service = Service.find(service_id)
    time = service.time * value
    price_total = service.price * time
    update_columns(time: time, price_total: price_total)
  end
end
