# encoding: utf-8
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :id
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    news_category = Category.create(:name => '站点新闻')
    chang_column :articles, :category_id, :integer, :default => news_category
  end
  def self.down
    change_column :articles, :category_id, :integer, :default => 0
    drop_table :categories
  end
end

