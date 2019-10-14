class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :code_promotion
      t.datetime :created_at
      t.datetime :finingdate_at

      t.timestamps
    end
  end
end
