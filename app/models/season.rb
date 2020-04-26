class Season < ActiveRecord::Base
  attr_accessible :number, :plot, :title
  has_many :episodes
end
