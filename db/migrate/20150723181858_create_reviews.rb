class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :submission_id
      t.integer :user_id
      t.text :comment
      t.integer :score

      t.timestamps null: false
    end
  end
end
