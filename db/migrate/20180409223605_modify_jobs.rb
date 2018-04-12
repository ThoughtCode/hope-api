class ModifyJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :service_id
    remove_column :jobs, :value
  end
end
