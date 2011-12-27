class AddBlogSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :entries_count, :integer, :null => false, :default => 0
    add_column :users, :blog_title, :string
    add_column :users, :enabled_comments, :boolean, :default => true
  end
  def down
    remove_column :users, :entries_count
    remove_column :users, :blog_title
    remove_column :users, :enabled_comments

  end
end
