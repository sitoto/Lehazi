class AddPortraitLocationToUser < ActiveRecord::Migration
  def change
    add_column :users, :portrait_location, :string, :null => false, :default => 'portrait.jpg'
  end
  def down
    remove_column :users, :portrait_location
  end
end
