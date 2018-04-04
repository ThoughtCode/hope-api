class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :city_id
      t.integer :neightborhood_id
      t.string :p_street
      t.string :number
      t.string :s_street
      t.string :details
      t.string :additional_reference
      t.string :phone
      t.string :cell_phone
      t.integer :customer_id
    end
  end
end
