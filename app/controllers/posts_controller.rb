class PostsController < ApplicationController
  
  before_action :correct_user, only: :destroy
  
  def index
    @posts = current_user.feed.all
    session[:return_page] = request.original_url
  end
  
  def create
    @post = current_user.posts.build(params.require(:post).permit(:body))
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      flash[:danger] = "There was an error!"
      redirect_to root_url
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
    
end
