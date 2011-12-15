class AddPubPhoneColumn < ActiveRecord::Migration
  def up
    add_column :infos, :pub_phone,:string
  end

  def down
    remove_column :infos, :pub_phone
  end
end
