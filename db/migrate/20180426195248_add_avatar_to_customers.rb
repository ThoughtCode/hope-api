class AddAvatarToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :avatar, :string
  end
end
