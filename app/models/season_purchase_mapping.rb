class SeasonPurchaseMapping < ActiveRecord::Base
  attr_accessible :season_id, :library_id, :purchase_time
  belongs_to :library
  belongs_to :season
  validates :season_id, :library_id, :purchase_time, :presence => true
end
