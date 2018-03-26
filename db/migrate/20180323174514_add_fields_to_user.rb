class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :national_id, :string
    add_column :customers, :cell_phone, :string
    add_column :customers, :birthday, :date

    add_column :agents, :first_name, :string
    add_column :agents, :last_name, :string
    add_column :agents, :national_id, :string
    add_column :agents, :cell_phone, :string
    add_column :agents, :birthday, :date
    add_column :agents, :status, :integer
  end
end
