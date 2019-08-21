class AddInvoiceIdToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :invoice_id, :integer
  end
end