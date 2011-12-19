class Category < ActiveRecord::Base
  has_many :articles, :dependent => :nullify  #you can dependent => :destroy to del all article
  has_many :infos, :dependent => :nullify

  validates_length_of :name, :maximum => 80
end
