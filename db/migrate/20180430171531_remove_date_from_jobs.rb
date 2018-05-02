class RemoveDateFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :date, :date
  end
end
