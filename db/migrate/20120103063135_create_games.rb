# encoding: utf-8
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :category_id   , :null =>false, :default => 4
      t.string :name       , :null =>false, :default => '游戏'
      t.string :company
      t.text :synopsis   , :limit =>2000
      t.string :logo
      t.string :ad_word
      t.boolean :is_new    , :null =>false, :default => false
      t.boolean :is_online  , :null =>false, :default => true
      t.boolean :sales     , :null =>false, :default => false
      t.string :sale_url
      t.integer :user_id    , :null =>false, :default => 1

      t.timestamps
    end
  end
end
