class RemoveColumnsFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :start_hour, :datetime
    remove_column :jobs, :end_hour, :datetime
  end
end
