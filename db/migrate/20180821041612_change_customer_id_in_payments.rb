class ChangeCustomerIdInPayments < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :user_id, :integer
    add_column :payments, :customer_id, :integer
    remove_column :payments, :status
    add_column :payments, :status, :string
  end
end
