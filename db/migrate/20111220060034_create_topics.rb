class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :forum_id
      t.integer :user_id
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :posts_count, :null => false, :default => 0

      t.timestamps
    end
    add_index :topics,:forum_id
  end
end
