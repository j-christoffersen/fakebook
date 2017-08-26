class FriendshipsController < ApplicationController
  def create
    @user = User.find params[:friend_id]
    current_user.add_friend @user
    respond_to do |format|
      format.html { redirect_to(session[:return_page] || root_path) }
      format.js
    end
  end
  
  def destroy
    @user = Friendship.find(params[:id]).user
    @friend = Friendship.find(params[:id]).friend
    @user.remove_friend @friend
    respond_to do |format|
      format.html { redirect_to(session[:return_page] || root_path) }
      format.js
    end
  end
  
end
