class AddStartedAtAndFinishedAtToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :started_at, :datetime
    add_column :jobs, :finished_at, :datetime
  end
end
