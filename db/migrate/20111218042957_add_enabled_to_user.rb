class AddEnabledToUser < ActiveRecord::Migration
  def change
    add_column :users, :enabled, :boolean ,:default =>true, :null =>false
  end
  def self.down
    remove_column  :users, :enabled
  end
end
