class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.sort_by!(&:created_at)
    respond_to do |format|
      format.json {render :json => @movies, :except => :id}
    end
  end

  def resource_list
    @movies = Movie.all
    @seasons = Season.all
    @combined_resource = @movies + @seasons
    @combined_resource = @combined_resource.sort_by!(&:created_at)
    respond_to do |format|
      format.json {render :json => @combined_resource, :except => :id}
    end
  end

end

