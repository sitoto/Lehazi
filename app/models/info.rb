class Info < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates_presence_of :title , :district , :area , :address , :pub_person ,:pub_time

end
