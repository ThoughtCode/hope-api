class AddAccessTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :access_token, :string
    add_column :customers, :access_token, :string
  end
end
