class Season < ActiveRecord::Base
  attr_accessible :number, :plot, :title
  has_many :episodes
  validates :title, :number, :presence => true
  attr_accessor :remaining_time

end
