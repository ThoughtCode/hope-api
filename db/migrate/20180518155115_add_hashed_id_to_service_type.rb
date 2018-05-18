class AddHashedIdToServiceType < ActiveRecord::Migration[5.1]
  def change
    add_column :service_types, :hashed_id, :string
  end
end
