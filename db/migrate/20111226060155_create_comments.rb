class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :entry_id
      t.integer :user_id
      t.string :guest_name
      t.string :guest_email
      t.text :body
      t.datetime :created_at

      t.timestamps
    end
    add_index :comments, :entry_id
  end
end
