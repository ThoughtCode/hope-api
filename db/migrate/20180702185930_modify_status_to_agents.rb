class ModifyStatusToAgents < ActiveRecord::Migration[5.1]
  def change
    remove_column :agents, :status, :integer
    add_column :agents, :status, :integer, default: 0
  end
end
