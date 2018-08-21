class AddCardToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :card_id, :string
    add_column :jobs, :installments, :integer
    
  end
end
