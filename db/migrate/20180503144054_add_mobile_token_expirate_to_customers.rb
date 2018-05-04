class AddMobileTokenExpirateToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :mobile_token_expiration, :datetime
  end
end
