class AddAvatarToAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :avatar, :string
  end
end
