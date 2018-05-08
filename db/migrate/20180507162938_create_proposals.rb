class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.string :hashed_id
      t.integer :job_id
      t.integer :agent_id
      t.integer :status
    end
  end
end
