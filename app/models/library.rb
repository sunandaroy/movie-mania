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
    current_time = Time.now
    all_contents = []
    self.movie_purchase_mappings.includes(:movie).each{|mapping|
      next if mapping.purchase_time < 2.day.ago
          movie_obj = mapping.movie
          movie_obj.remaining_time = current_time - mapping.purchase_time
          all_contents.push(movie_obj)
          }
    self.season_purchase_mappings.includes(:season).each{|mapping|
      next if mapping.purchase_time < 2.day.ago
      season_obj = mapping.season
        season_obj.remaining_time = current_time - mapping.purchase_time
      all_contents.push(season_obj)
    }
    user_contents = all_contents.sort_by!{|a| a.remaining_time}
    user_contents
  end

end
