class AddMobileTokenToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :mobile_push_token, :string
    add_column :agents, :mobile_push_token, :string
  end
end
