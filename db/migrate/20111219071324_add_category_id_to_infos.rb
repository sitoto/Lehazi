class AddCategoryIdToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :category_id,:integer, :default => 0
  end
  def self.down
    remove_column :infos, :category_id
  end
end
