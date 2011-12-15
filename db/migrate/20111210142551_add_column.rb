class AddColumn < ActiveRecord::Migration
  def up
    add_column :infos, :district, :string
  end

  def down
    remove_column :infos, :district
  end
end
