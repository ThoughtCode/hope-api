class AddCustomNotification < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :status
    add_column :notifications, :status, :integer, default: 1
  end
end
