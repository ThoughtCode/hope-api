class AddDeletedToInvoiceDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :invoice_details, :deleted, :boolean, default: false
  end
end
