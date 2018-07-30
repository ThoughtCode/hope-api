class AddFinishedRecurrencyAtToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :finished_recurrency_at, :datetime
  end
end
