class AddFLzUpdatedAtToTopics < ActiveRecord::Migration
  def self.up
  add_column :topics, :f_lz_updated_at, :datetime
  end
  def self.down
    remove_column :topics, :f_lz_updated_at
  end
end
