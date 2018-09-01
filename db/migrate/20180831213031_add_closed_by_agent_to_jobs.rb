class AddClosedByAgentToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :closed_by_agent, :boolean, default: false
  end
end
