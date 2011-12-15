class Info < ActiveRecord::Base
  validates_presence_of :title , :district , :area , :address , :pub_person ,:pub_time
end
