class Promotion < ApplicationRecord
  include SerializableModel

  belongs_to :service

  enum status: { pendig: 0, active: 1 }

  validate :check_promo_code_format
  validates_presence_of :name, :promo_code, :started_at, :finished_at, :service_id, :discount, :status

  before_save :promo_code_to_upper
  before_save :set_finished_at_end_of_day

  # scopes available
  scope :available, -> { where('NOW() BETWEEN started_at AND finished_at AND status = 1') }

  def serialize!
    columns = [
      :name, :discount, :promo_code, service: [:id, :name]
    ]
    self.serialize_row!(columns)
  end

  private

  def check_promo_code_format
    if self.promo_code.match(/\s/)
      errors.add(:promo_code, "No debe escribir espacios en blanco en los codigos de promocion")
    end
  end

  def promo_code_to_upper
    self.promo_code = self.promo_code.upcase
  end

  def set_finished_at_end_of_day
    self.finished_at = self.finished_at.end_of_day
  end
end
