require 'test_helper'

class AddFriendTestTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rick)
    @other = users(:morty)
    sign_in(@user)
  end
  
  test "should add friend the standard way" do
    assert_difference ['@user.friends.count', '@other.friends.count'], 1 do
      post friendships_path, params: { friend_id: @other.id }
    end
  end

  test "should add friend with Ajax" do
    assert_difference ['@user.friends.count', '@other.friends.count'], 1 do
      post friendships_path, xhr: true, params: { friend_id: @other.id }
    end
  end

  test "should remove friend a user the standard way" do
    @user.add_friend(@other)
    friendship = @user.friendships.find_by(friend_id: @other.id)
    assert_difference ['@user.friends.count', '@other.friends.count'], -1 do
      delete friendship_path(friendship)
    end
  end

  test "should remove friend a user with Ajax" do
    @user.add_friend(@other)
    friendship = @user.friendships.find_by(friend_id: @other.id)
    assert_difference ['@user.friends.count', '@other.friends.count'], -1 do
      delete friendship_path(friendship), xhr: true
    end
  end
  
end
