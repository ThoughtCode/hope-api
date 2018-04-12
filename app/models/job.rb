class Job < ApplicationRecord
  belongs_to :agent, optional: true
  belongs_to :property
  has_many :job_details, dependent: :destroy
  has_many :services, through: :job_details
  after_save :calculate_price

  accepts_nested_attributes_for :job_details

  private

  def calculate_price
    duration = job_details.sum(:time)
    total = job_details.sum(:price_total)
    update_columns(duration: duration, total: total)
  end
end
