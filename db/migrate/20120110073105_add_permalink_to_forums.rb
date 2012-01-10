class AddPermalinkToForums < ActiveRecord::Migration
  def self.up
    add_column :forums, :permalink, :string, :default => ""
  end
  def self.down
    remove_column :forums, :permalink
  end
end
