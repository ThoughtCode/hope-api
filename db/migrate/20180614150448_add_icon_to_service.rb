class AddIconToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :icon, :string
  end
end
