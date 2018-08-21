class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :job_id
      t.integer :credit_card_id
      t.string :amount
      t.string :description
      t.string :vat
      t.integer :status
      t.datetime :payment_date
      t.string :authorization_code
      t.string :installments
      t.string :message
      t.string :carrier_code
      t.integer :status_detail

      t.timestamps
    end
  end
end
