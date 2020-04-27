class Movie < ActiveRecord::Base
  validates :title, :presence => true
  attr_accessible :plot, :title

end
