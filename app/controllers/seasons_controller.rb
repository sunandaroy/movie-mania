class SeasonsController < ApplicationController

  def index
    @seasons = Season.includes(:episodes).all
    @season = @seasons.sort_by(&:created_at)
    @seasons.each{|s|
      @episodes =s.episodes
      s[:episodes] = @episodes
    }

    respond_to do |format|
      format.json {render :json => @seasons}
    end
  end

end
