class AddIsReceiptToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :is_receipt_cancel, :boolean, default: :false
  end
end
