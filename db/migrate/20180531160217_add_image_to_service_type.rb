class AddImageToServiceType < ActiveRecord::Migration[5.1]
  def change
    add_column :service_types, :image, :string
  end
end
