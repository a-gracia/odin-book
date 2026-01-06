require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get posts list" do
    sign_in users(:one)
    get posts_path
    assert_response :success
  end

  test "should create post" do
    sign_in users(:one)

    assert_difference("Post.count", +1) do
      post posts_path, params: { post: { body: "hola" } }
    end
  end
end
