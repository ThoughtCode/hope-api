class AddDeletedToCreditCards < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :deleted, :boolean, default: false
  end
end
