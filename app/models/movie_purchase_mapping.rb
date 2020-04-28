class MoviePurchaseMapping < ActiveRecord::Base
  belongs_to :library
  belongs_to :movie
  validates :movie_id, :library_id, :purchase_time, :presence => true
  attr_accessible :movie_id, :library_id, :purchase_time

end
