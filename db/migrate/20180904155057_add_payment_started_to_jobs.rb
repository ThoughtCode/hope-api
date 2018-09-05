class AddPaymentStartedToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :payment_started, :boolean, default: false
  end
end
