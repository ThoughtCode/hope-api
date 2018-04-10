class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.integer :service_type_id
      t.integer :type_service
      t.string :name
      t.boolean :quantity
      t.float :time
      t.float :price
    end
  end
end
