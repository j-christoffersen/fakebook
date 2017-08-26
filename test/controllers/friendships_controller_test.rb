require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:rick)
    @other_user = users(:morty)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Friendship.count' do
      post friendships_path, params: { friend_id: @user.id }
    end
    assert_redirected_to new_user_session_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Friendship.count' do
      delete friendship_path(friendships(:one))
    end
    assert_redirected_to new_user_session_url
  end
end
