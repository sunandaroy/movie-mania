class Library < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user
  has_many :movie_purchase_mappings
  has_many :movies,  :through => :movie_purchase_mappings
  has_many :season_purchase_mappings
  has_many :seasons, :through => :season_purchase_mappings
end
