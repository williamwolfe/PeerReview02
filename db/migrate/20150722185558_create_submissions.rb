class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :link

      t.timestamps null: false
    end
  end
end
