class AddValueToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :value, :integer
  end
end
