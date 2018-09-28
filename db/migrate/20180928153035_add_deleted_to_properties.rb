class AddDeletedToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :deleted, :boolean, default: false
  end
end
