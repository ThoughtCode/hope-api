class AddInvoiceDetailIdToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :invoice_detail_id, :integer
  end
end
