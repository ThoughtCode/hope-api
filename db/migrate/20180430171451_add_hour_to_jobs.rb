class AddHourToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :start_hour, :datetime
    add_column :jobs, :end_hour, :datetime
  end
end
