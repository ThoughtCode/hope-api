class CreateReview < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :hashed_id
      t.belongs_to :job, foreign_key: true
      t.references :owner, polymorphic: true, index: true
      t.text :comment
      t.integer :qualification, default: 0
    end
  end
end
