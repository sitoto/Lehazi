class Category < ActiveRecord::Base
  has_many :articles, :dependent => :nullify  #you can dependent => :destroy to del all article
  has_many :infos, :dependent => :nullify
  has_many :funs, :dependent => :nullify
  has_many :novels, :dependent => :nullify
  has_many :games, :dependent => :nullify


  validates_length_of :name, :maximum => 80
end
