class UsersController < ApplicationController

  def find_item(content_type, content_id, library)
    if content_type == "movie"
      content = library.movies.where(id: content_id)
    else
      content = library.seasons.where(id: content_id)
    end
      content
  end

  def register_content_purchase(content_type, content_id, library)
    if content_type == "movie"
      purchase_time = Time.now
      movie_purchase_mapping = MoviePurchaseMapping.create(movie_id: content_id, library_id: library.id, purchase_time: purchase_time)
    else
      purchase_time = Time.now
      movie_purchase_mapping = SeasonPurchaseMapping.create(season_id: content_id, library_id: library.id, purchase_time: purchase_time)
    end
  end



  def purchase
    #expects to have two parameters content_type either movie or season and content_id
    @user = User.find(params["id"].to_i)
    if params[:content_id].present? && params[:content_type].present?
      @user_library = @user.library
      content = find_item(params[:content_type], params[:content_id].to_i, @user_library)
      if content.empty?
        register_content_purchase(params[:content_type], params[:content_id].to_i, @user_library)
         render json: {code: 200, message: "your purchase has been registered"}
      end
    else
      render json: {status: "error", code: 400}
    end
  end

  def all_contents
    user_id = params[:id].to_i
    @user = User.find(user_id)
    @user_library = @user.library
    @user_contents = get_all_alive_contents(@user_library)
    respond_to do |format|
    format.json {render :json => @user_contents}
    end
    @user_contents
  end

  def get_all_alive_contents(library)
    @user_movie_contents  = library.movies.where('purchase_time >= ?', 2.day.ago)
    @user_season_contents = library.seasons.where('purchase_time >= ?', 2.day.ago)
    @user_contents = @user_movie_contents + @user_season_contents
    @user_contents
  end
end

