class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :name, null: false
      t.string :promo_code, null: false
      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
      t.belongs_to :service
      t.decimal :discount, :precision => 5, :scale => 2, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
