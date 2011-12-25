class CreateUsersIndexsBeforeChangeCode < ActiveRecord::Migration
  def up
      add_index :users, ["login"], :name => "index_users_on_login", :unique => true
      add_index :users, ["email"], :name => "index_users_on_email", :unique => true
      add_index :users, ["persistence_token"], :name => "idx_users_persistence", :unique => true
  end

  def down
  end
end
