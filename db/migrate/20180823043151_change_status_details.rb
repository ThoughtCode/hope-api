class ChangeStatusDetails < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :status_detail, :integer
    add_column :payments, :status_detail, :string
  end
end
