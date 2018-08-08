class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :info
      t.integer :status
      t.belongs_to :customer
      t.belongs_to :agent
      t.belongs_to :job

      t.timestamps
    end
  end
end
