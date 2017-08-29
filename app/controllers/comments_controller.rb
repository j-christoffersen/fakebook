class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(params.require(:comment).permit(:content, :post_id))
    if comment.save
      redirect_to root_url
    else
      flash[:danger] = 'Something went wrong!'
      redirect_to root_url
    end
  end
  
  def destroy
    @comment = Comment.find params[:id]
    @like.destroy
    @posts = current_user.feed.all
    redirect_to root_url
  end
end
