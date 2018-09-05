class AddReceiptSendToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :receipt_send, :boolean, default: false
  end
end
