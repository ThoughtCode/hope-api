class AddVatToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :vat, :float
    add_column :jobs, :service_fee, :float
  end
end
