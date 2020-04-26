class Movie < ActiveRecord::Base
  attr_accessible :plot, :title
  validates :title, :presence => true
end
