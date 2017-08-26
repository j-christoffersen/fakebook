require 'test_helper'

class FriendingTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:rick)
    @other = users(:morty)
    sign_in(@user)
  end
end
