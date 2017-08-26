class FriendshipsController < ApplicationController
  def create
    @user = User.find params[:friend_id]
    current_user.add_friend @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    @user = Friendship.find(params[:id]).friend
    current_user.remove_friend @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
end
