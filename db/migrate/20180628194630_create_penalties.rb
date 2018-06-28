class CreatePenalties < ActiveRecord::Migration[5.1]
  def change
    create_table :penalties do |t|
      t.integer :amount
      t.boolean :paid, :false
      t.integer :customer_id
    end
  end
end
