class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :comments_count  ,:null => false, :default => 0
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :entries, :user_id
  end
end
