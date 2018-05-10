class ModifyStatusToJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :status, :integer
    add_column :jobs, :status, :integer, default: 0
  end
end
