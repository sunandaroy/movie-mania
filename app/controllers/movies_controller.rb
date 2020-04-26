class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.sort_by(&:created_at)
    respond_to do |format|
      format.json {render :json => @movies}
    end
  end

  def resource_list
    @movies = Movie.all.sort_by(&:created_at)
    @seasons = Season.all.sort_by(&:created_at)
    @combined_resource = @movies + @seasons
    respond_to do |format|
      format.json {render :json => @combined_resource}
    end
  end

end

