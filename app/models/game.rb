class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :name, :synopsis
  validates_length_of :name, :within => 3..70
  validates_length_of :synopsis, :maximum => 2000

  before_create :set_permalink

  def set_permalink
    @attributes['permalink'] = name.downcase.gsub(/\s+/, '_')
    #@attributes['permalink'] = name.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end

  def to_param
    "#{id}-#{permalink}"
  end
end
