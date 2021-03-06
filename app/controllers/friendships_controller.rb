class FriendshipsController < ApplicationController
  def create
    @user = User.find params[:friend_id]
    current_user.add_friend @user
    respond_to do |format|
      format.html { redirect_to(session[:return_page] || root_path) }
      format.js do
        if session[:return_page] == users_url
          render 'refresh_user.js'
        else
          render 'create.js'
        end
      end
    end
  end
  
  def destroy
    friendship = Friendship.find(params[:id])
    @user = friendship.friend
    @sender = friendship.user
    @sender.remove_friend @user
    #current_user.remove_friend @user
    respond_to do |format|
      format.html { redirect_to(session[:return_page] || root_path) }
      format.js do
        if session[:return_page] == users_url
          render 'refresh_user.js'
        else
          render 'destroy.js'
        end
      end
    end
  end
  
end
