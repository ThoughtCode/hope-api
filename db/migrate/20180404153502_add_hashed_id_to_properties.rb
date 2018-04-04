class AddHashedIdToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :hashed_id, :string
  end
end
