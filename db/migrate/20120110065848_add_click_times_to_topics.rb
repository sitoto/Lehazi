class AddClickTimesToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :click_times,:integer, :default => 1
    add_column :topics, :from_url,:string, :default => ""

    add_index :topics,:from_url
  end
  def self.down
    remove_column :topics, :click_times
    remove_column :topics, :from_url
  end


end
