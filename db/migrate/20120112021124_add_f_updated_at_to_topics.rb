class AddFUpdatedAtToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :f_updated_at, :datetime
  end
  def self.down
    remove_column :topics, :f_updated_at
  end
end
