class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    my_posts = current_user.posts
    followed_posts = Post.where(user: current_user.following_accepted)

    @posts = (my_posts + followed_posts).reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to :root, notice: "Post successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.expect(post: [ :body ])
  end
end
