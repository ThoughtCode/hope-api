class CreateConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.string :key
      t.text :value
      t.text :description
    end
  end
end
