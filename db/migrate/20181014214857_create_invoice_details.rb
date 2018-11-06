class CreateInvoiceDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_details do |t|
      t.string :email
      t.string :identification
      t.integer :identification_type
      t.string :social_reason
      t.string :address
      t.string :telephone
      t.integer :customer_id

      t.timestamps
    end
  end
end
