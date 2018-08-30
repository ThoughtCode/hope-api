class AddCreditCardIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :job_id, :integer
  end
end
