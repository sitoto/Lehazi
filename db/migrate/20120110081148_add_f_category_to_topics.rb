class AddFCategoryToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :f_category, :string, :default => ""
  end
  def self.down
    remove_column :topics, :f_category
  end
end
