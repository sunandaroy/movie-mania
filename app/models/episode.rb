class Episode < ActiveRecord::Base
  validates :title, :number, :presence => true
  belongs_to :season
  attr_accessible :plot, :title, :number, :season_id
end
