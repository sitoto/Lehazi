class CreateFriendLinks < ActiveRecord::Migration
  def change
    create_table :friend_links do |t|
      t.string :name
      t.string :url ,:null => false, :default => 'http://www.lehazi.com'
      t.string :logo
      t.integer :level ,:null => false, :default => 0
      t.boolean :published ,:null => false, :default => 1

      t.timestamps
    end
    add_index :friend_links, :name
  end
end
