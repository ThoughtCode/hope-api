class ModifyAgentToJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :agent_id
    add_column :jobs, :agent_id, :integer, null: true
  end
end
