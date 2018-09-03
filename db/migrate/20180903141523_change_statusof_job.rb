class ChangeStatusofJob < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :closed_by_agent, :boolean
    add_column :jobs, :closed_by_agent, :boolean
  end
end
