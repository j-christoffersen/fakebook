class NotificationsController < ApplicationController
  def index
    session[:return_page] = request.original_url
    @notifications = current_user.notifications
  end
end
