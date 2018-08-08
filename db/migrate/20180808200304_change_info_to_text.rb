class ChangeInfoToText < ActiveRecord::Migration[5.1]
  def change
  	rename_column :notifications, :info, :text
  end
end
