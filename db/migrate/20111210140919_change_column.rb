class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :infos , :floor, :string
    change_column :infos , :area, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
