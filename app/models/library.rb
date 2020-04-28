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

  def alive_movies_with_remaining_time(type)
    current_time = Time.now
    all_contents = []
    mappings = type == "movie" ? self.movie_purchase_mappings.includes(:movie).where('purchase_time >= ?',2.day.ago) : self.season_purchase_mappings.includes(:season).where('purchase_time >= ?', 2.day.ago)
    mappings.each{|mapping|
      resource_obj = type == "movie" ? mapping.movie : mapping.season
      resource_obj.remaining_time = current_time - mapping.purchase_time
      all_contents.push(resource_obj)
    }
    all_contents
  end

  def get_all_alive_contents
    all_contents = alive_movies_with_remaining_time("movie") + alive_movies_with_remaining_time("season")
    user_contents = all_contents.sort_by!{|a| a.remaining_time}
    user_contents
  end

end
