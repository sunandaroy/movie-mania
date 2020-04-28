class Movie < ActiveRecord::Base
  validates :title, :presence => true
  attr_accessible :plot, :title
  attr_accessor :remaining_time

end
