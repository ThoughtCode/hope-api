class AddHashedIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :hashed_id, :string
  end
end
