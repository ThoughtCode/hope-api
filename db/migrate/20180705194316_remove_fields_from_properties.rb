class RemoveFieldsFromProperties < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :details, :string
    remove_column :properties, :cell_phone, :string
  end
end
