class AddInvoiceIdToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :invoice_id, :integer
  end
end


 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 81, 86, 95, 96, 101, 102, 103, 124,
  , 172]

Job.find([153, 164]).each do |job|
  Invoice.create(customer: job.property.customer, job: job, invoice_detail_id: 51)
end