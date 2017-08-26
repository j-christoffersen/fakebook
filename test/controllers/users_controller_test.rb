require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:rick)
    @other_user = users(:morty)
  end
  
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to new_user_session_url
  end
    
  test "should redirect show when not logged in" do
    get user_path @user
    assert_redirected_to new_user_session_url
  end

  test "should get index when logged in" do
    sign_in @user
    get users_path
    assert_response :success
  end

end
