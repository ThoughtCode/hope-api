class AddOnlineToAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :online, :boolean, default: true
  end
end
