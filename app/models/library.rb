class Library < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user
  has_many :movie_purchase_mappings
  has_many :movies,  :through => :movie_purchase_mappings
  has_many :season_purchase_mappings
  has_many :seasons, :through => :season_purchase_mappings



  def get_contents(content_type, content_title)
    if content_type == "movie"
      content = self.movies.where(title: content_title)
    else
      content = self.seasons.where(id: content_title)
    end
    content
  end

  def register_content_purchase(content_type, content_title)
    if content_type == "movie"
      purchase_time = Time.now
      content_id = Movie.where(title: content_title).last.id
      movie_purchase_mapping = MoviePurchaseMapping.create(movie_id: content_id, library_id: self.id, purchase_time: purchase_time)
    else
      purchase_time = Time.now
      content_id = Season.where(title: content_title).last.id
      movie_purchase_mapping = SeasonPurchaseMapping.create(season_id: content_id, library_id: self.id, purchase_time: purchase_time)
    end
  end

  def get_all_alive_contents
    user_movie_contents  = self.movies.where('purchase_time >= ?', 2.day.ago)
    user_season_contents = self.seasons.where('purchase_time >= ?', 2.day.ago)
    user_contents = user_movie_contents + user_season_contents
    user_contents
  end

end
