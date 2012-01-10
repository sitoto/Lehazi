class AddPermalinkToGames < ActiveRecord::Migration
  def change
    add_column :games, :permalink,:string, :default => ""
  end
  def self.down
    remove_column :games, :permalink
  end
end
