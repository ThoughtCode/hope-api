class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :holder_name
      t.string :card_type
      t.string :number
      t.string :customer_id
      t.string :token
      t.string :status
      t.string :expiry_month
      t.string :expiry_year
      t.timestamps
    end
  end
end
