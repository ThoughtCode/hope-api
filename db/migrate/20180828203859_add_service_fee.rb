class AddServiceFee < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :agent_earnings, :decimal, :precision => 8, :scale => 2
  end
end
