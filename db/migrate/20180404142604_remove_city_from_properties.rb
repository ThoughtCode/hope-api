class RemoveCityFromProperties < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :city_id
  end
end
