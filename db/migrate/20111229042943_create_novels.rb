# encoding: utf-8
class CreateNovels < ActiveRecord::Migration
  def change
    create_table :novels do |t|
      t.integer :category_id   , :null =>false, :default => 0
      t.string :title    , :null =>false, :default => '小说'
      t.string :author    , :null =>false, :default => '网友'
      t.text :synopsis   , :limit =>1000
      t.integer :word_num    , :null =>false, :default => 0
      t.datetime :created_at
      t.string :from_name    , :null =>false, :default => '未知'
      t.string :from_url      , :null =>false, :default => 'http://www.lehazi.com/novels'
      t.text :other_from
      t.boolean :free,   :default => false
      t.integer :click_time, :null => false, :default => 0

      t.timestamps
    end
  end
end
