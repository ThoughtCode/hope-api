class AddPromotionIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :promotion, foreign_key: false, null: true
  end
end
