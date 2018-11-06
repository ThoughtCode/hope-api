class Invoice < ApplicationRecord
  belongs_to :job
  belongs_to :customer
  belongs_to :invoice_detail
  after_create :send_to_datil

  def send_to_datil
    # Send when payment is send.
    # Invoices.generate_for_job(self, self.job.payment, self.job)
  end
end
