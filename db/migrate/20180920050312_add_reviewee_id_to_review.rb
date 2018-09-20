class AddRevieweeIdToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :reviewee_id, :integer
    add_column :reviews, :reviewee_type, :string
  end
end
