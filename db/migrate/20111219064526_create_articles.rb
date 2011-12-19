class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :synopsis , :limit =>1000
      t.text :body,  :limit =>20000
      t.boolean :published,  :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :published_at
      t.integer :category_id

    end
  end
end
