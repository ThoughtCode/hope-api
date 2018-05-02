class AddMobileTokenToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :mobile_token, :integer
  end
end
