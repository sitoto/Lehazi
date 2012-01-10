class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :delete_all
  has_many :posts, :through =>  :topics

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_length_of :description, :maximum => 1000
  validates_presence_of :permalink
  validates_length_of :permalink, :maximum => 10

  before_save :set_permalink

  def set_permalink
    @attributes['permalink'] = permalink.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end

  def to_param
    "#{id}-#{permalink}"
  end
end
