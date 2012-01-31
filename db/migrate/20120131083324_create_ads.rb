class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name ,:null => false
      t.string :from  ,:null => false
      t.text :body
      t.boolean :word ,:null => false, :default => 0
      t.boolean :pic   ,:null => false, :default => 0
      t.integer :width  ,:null => false, :default => 0
      t.integer :height ,:null => false, :default => 0
      t.boolean :published    ,:null => false, :default => 1
      t.integer :weight ,:null => false, :default => 0

      t.timestamps
    end
  end
end
