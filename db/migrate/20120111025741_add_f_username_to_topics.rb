class AddFUsernameToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :f_username, :string, :default => ""
  end
  def self.down
    remove_column :topics, :f_username
  end
end
