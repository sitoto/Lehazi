class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :topics_count, :null =>false, :default => 0

      t.timestamps
    end
  end
end
