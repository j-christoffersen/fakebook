class LikesController < ApplicationController
  
  def create
    Post.find(params[:post_id]).likers << current_user
    @posts = current_user.feed.all
    @index = params[:index].to_i
    respond_to do |format|
      format.html { redirect_to(session[:return_page] || root_path) }
      format.js
    end
  end
  
  def destroy
    @like = Like.find params[:id]
    @like.destroy
    @posts = current_user.feed.all
    @index = params[:index].to_i
    respond_to do |format|
      format.html { redirect_to(session[:return_page] || root_path) }
      format.js
    end
  end
  
end
