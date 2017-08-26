class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    session[:return_page] = request.original_url
  end

  def index
    @users = User.all
  end
end
