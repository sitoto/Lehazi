class AddHotNumToGames < ActiveRecord::Migration
  def change
    add_column :games, :hot_num,:integer, :default => 0
  end
  def self.down
    remove_column :games, :hot_num
  end
end
