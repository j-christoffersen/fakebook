require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  def setup
    @user = users(:rick)
    @user.add_friend users(:poopy)
    users(:poopy).add_friend @user
  end
  
  test "comments on own post" do
    sign_in @user
    assert_difference "Comment.count", 1 do
      post comments_path, params: { comment: { content: "AIDS!", post_id: posts(:wub).id } }
    end
  end
  
  test "comments on friends post" do
    sign_in @user
    assert @user.friends_with? posts(:ooo).user
    assert_difference "Comment.count", 1 do
      post comments_path, params: { comment: { content: "Yeah, MPB!", post_id: posts(:ooo).id } }
    end
  end
  
  test "does not comment on non-friend's post" do
    sign_in @user
    assert_difference "Comment.count", 0 do
      post comments_path, params: { comment: { content: "Shut up, MORTY!", post_id: posts(:gee).id } }
    end
  end
    
end
