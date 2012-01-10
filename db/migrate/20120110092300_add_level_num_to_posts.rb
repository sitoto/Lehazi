class AddLevelNumToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :f_level_num, :integer, :default => 1
  end
  def self.down
    remove_column :posts, :f_level_num
  end
end
