class AddHashedIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :hashed_id, :string
    add_column :customers, :hashed_id, :string
  end
end
