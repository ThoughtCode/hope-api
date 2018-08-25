class ChangeDecimalJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :job_details, :price_total, :float
    add_column :job_details, :price_total, :decimal, :precision => 8, :scale => 2
    remove_column :jobs, :total, :float
    add_column :jobs, :total, :decimal, :precision => 8, :scale => 2
    remove_column :jobs, :vat, :float
    add_column :jobs, :vat, :decimal, :precision => 8, :scale => 2
    remove_column :jobs, :service_fee, :float
    add_column :jobs, :service_fee, :decimal, :precision => 8, :scale => 2
    add_column :jobs, :subtotal, :decimal, :precision => 8, :scale => 2
  end
end