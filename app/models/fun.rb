class Fun < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :title
  validates_presence_of :body
  validates_length_of :title, :maximum => 255
  validates_length_of :body, :maximum => 2000

end
