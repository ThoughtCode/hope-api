class ModifyValueToConfigs < ActiveRecord::Migration[5.1]
  def change
    remove_column :configs, :value, :text
    add_column :configs, :value, :string
  end
end
