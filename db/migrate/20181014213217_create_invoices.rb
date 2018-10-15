class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :job_id

      t.timestamps
    end
  end
end
