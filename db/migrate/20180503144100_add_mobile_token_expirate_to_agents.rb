class AddMobileTokenExpirateToAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :mobile_token_expiration, :datetime
  end
end
