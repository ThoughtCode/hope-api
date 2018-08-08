class ChangeNotificationInfo < ActiveRecord::Migration[5.1]
  def change
    change_column :notifications, :info, :string
  end
end
