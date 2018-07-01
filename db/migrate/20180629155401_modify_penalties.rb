class ModifyPenalties < ActiveRecord::Migration[5.1]
  def change
    remove_column :penalties, :false, :boolean
    remove_column :penalties, :paid, :boolean
    add_column :penalties, :paid, :boolean, default: :false
  end
end
