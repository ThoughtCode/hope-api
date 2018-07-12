class AddDetailsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :details, :text
  end
end
