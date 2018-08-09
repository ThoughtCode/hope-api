class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :text
      t.integer :status, default: 1
      t.belongs_to :customer
      t.belongs_to :agent
      t.belongs_to :job

      t.timestamps
    end
  end
end
