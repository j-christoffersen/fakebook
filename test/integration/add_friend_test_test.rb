require 'test_helper'

class AddFriendTestTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rick)
    @other = users(:morty)
    sign_in(@user)
  end
  
  test "should send request the standard way" do
    assert_difference '@user.friend_requests.count', 1 do
      post friendships_path, params: { friend_id: @other.id }
    end
  end

  test "should send request with Ajax" do
    assert_difference '@user.friend_requests.count', 1 do
      post friendships_path, xhr: true, params: { friend_id: @other.id }
    end
  end

  test "should accept friend the standard way" do
    @other.add_friend(@user)
    assert_difference ['@user.friends.count', '@other.friends.count'], 1 do
      post friendships_path, params: { friend_id: @other.id }
    end
  end
  
  test "should accept friend the with ajax" do
    @other.add_friend(@user)
    assert_difference ['@user.friends.count', '@other.friends.count'], 1 do
      post friendships_path, params: { friend_id: @other.id }, xhr: true
    end
  end
  
  test "should remove friend request the standard way" do
    @user.add_friend(@other)
    friendship = @user.friend_requestings.find_by(friend_id: @other.id)
    assert_difference '@user.friend_requests.count', -1 do
      delete friendship_path(friendship)
    end
  end

  test "should remove friend request with ajax" do
    @user.add_friend(@other)
    friendship = @user.friend_requestings.find_by(friend_id: @other.id)
    assert_difference '@user.friend_requests.count', -1 do
      delete friendship_path(friendship), xhr: true
    end
  end
  
  test "should reject friend request the standard way" do
    @other.add_friend(@user)
    friendship = @other.friend_requestings.find_by(friend_id: @user.id)
    assert_difference '@other.friend_requests.count', -1 do
      delete friendship_path(friendship)
    end
  end
  
  test "should reject friend request with ajax" do
    @other.add_friend(@user)
    friendship = @other.friend_requestings.find_by(friend_id: @user.id)
    assert_difference '@other.friend_requests.count', -1 do
      delete friendship_path(friendship), xhr: true
    end
  end
  
  test "should remove friend the standard way" do
    @user.add_friend(@other)
    @other.add_friend(@user)
    friendship = @user.friend_requestings.find_by(friend_id: @other.id)
    assert_difference ['@user.friends.count', '@other.friends.count'], -1 do
      delete friendship_path(friendship)
    end
  end
  
  test "should remove friend with Ajax" do
    @user.add_friend(@other)
    @other.add_friend(@user)
    friendship = @user.friend_requestings.find_by(friend_id: @other.id)
    assert_difference ['@user.friends.count', '@other.friends.count'], -1 do
      delete friendship_path(friendship), xhr: true
    end
  end
  
  test "send request interface" do
    get user_path @other
    assert_select "input[value=?]", "Add Friend"
    assert_difference '@user.friend_requests.count', 1 do
      post friendships_path, params: { friend_id: @other.id }
    end
    assert_redirected_to user_path(@other)
    follow_redirect!
    assert_select "input[value=?]", "Request Sent"
  end
  
end
