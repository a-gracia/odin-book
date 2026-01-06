require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should not save post without body" do
    post = Post.new
    post.user = users(:one)
    assert_not post.save
  end
end
