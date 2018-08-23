class AddTransactionIdToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :transaction_identifier, :string
  end
end
