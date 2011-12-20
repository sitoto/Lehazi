class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :topic_id
      t.integer :user_id
      t.text :body
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :posts, :topic_id
  end
end
