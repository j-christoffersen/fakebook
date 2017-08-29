require 'test_helper'

class PostInterfaceTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:rick)
  end
  
  test "post interface" do
    sign_in @user
    get root_path
    assert_select "textarea"
    # Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { body: "" } }
    end
    # Valid submission
    content = "It's just two brothers!"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { body: content } }
    end
  end
end
