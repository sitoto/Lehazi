class CreateRentInfos < ActiveRecord::Migration
  def change
    create_table :rent_infos do |t|
      t.string :title
      t.string :address
      t.string :rent
      t.integer :area
      t.string :style
      t.integer :floor
      t.string :config
      t.text :description
      t.string :pub_person
      t.string :pub_person_tel_image_url
      t.datetime :pub_time

      t.timestamps
    end
  end
end
