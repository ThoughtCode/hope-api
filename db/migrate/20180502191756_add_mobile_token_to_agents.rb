class AddMobileTokenToAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :mobile_token, :integer
  end
end
