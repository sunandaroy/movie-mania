class Episode < ActiveRecord::Base
  belongs_to :season
  attr_accessible :plot, :title, :season_id
end
