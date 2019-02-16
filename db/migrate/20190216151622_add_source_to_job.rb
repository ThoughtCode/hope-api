class AddSourceToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :source, :integer, default: 0
  end
end
