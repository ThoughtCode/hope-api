class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.integer :customer_id
      t.integer :property_id
      t.integer :agent_id, null: false
      t.integer :service_id
      t.integer :status
    end
  end
end
