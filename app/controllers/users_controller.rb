class UsersController < ApplicationController
  before_filter :validate_params_for_purchase, only: :purchase

  def validate_params_for_purchase
    if !params[:content_id].present? || !params[:content_type].present?
      render json: {status: "error", code: 400, message: "insufficient data"}
    elsif !(["movie", "season"].include? params[:content_type])
      render json: {status: "error", code: 400, message: "Incorrect information"}
    end
  end

  def purchase
    #expects to have two parameters content_type and content_id
    @user = User.find(params["id"].to_i)
    if params[:content_id].present? && params[:content_type].present?
      @user_library = @user.library
      content = @user_library.get_contents(params[:content_type], params[:content_id].to_i)
      if content.empty?
        @user_library.register_content_purchase(params[:content_type], params[:content_id].to_i)
         render json: {code: 200, message: "your purchase has been registered"}
      else
        render json: {status: "error", code: 400}
      end
    end
  end

  def all_contents
    user_id = params[:id].to_i
    @user = User.find(user_id)
    @user_library = @user.library
    #@user_contents = get_all_alive_contents(@user_library)
    @user_contents = @user_library.get_all_alive_contents
    respond_to do |format|
    format.json {render :json => @user_contents}
    end
    @user_contents
  end

end

