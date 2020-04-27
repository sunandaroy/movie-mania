class SeasonsController < ApplicationController

  def index
    @seasons = Season.includes(:episodes).all
    @seasons = @seasons.sort_by!(&:created_at)
    @seasons.each{|s|
      season_episodes = s.episodes
      season_episodes = season_episodes.sort_by!(&:number)
      s[:episodes] = season_episodes
    }
    respond_to do |format|
      format.json {render :json => @seasons}
    end
  end

end
