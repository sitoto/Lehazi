class AddLastFromUrlToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_from_url, :string
  end
  def self.down
    remove_column :topics, :last_from_url
  end
end
