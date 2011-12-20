class AddUserPostsCount < ActiveRecord::Migration
  def up
    add_column :users, :posts_count, :integer, :null => false, :default => 0
  end

  def down
    remove_column :users, :posts_count
  end
end
