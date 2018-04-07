class CreateJobDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :job_details do |t|
      t.integer :job_id
      t.integer :service_id
      t.integer :value
    end
  end
end
