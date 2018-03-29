class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.string :neighborhood, null: false
      t.string :p_street, null: false
      t.string :number, null: false
      t.string :s_street, null: false
      t.string :details, null: false
      t.string :additional_reference, null: false
      t.string :phone, null: false
      t.string :cell_phone, null: false
    end
  end
end
