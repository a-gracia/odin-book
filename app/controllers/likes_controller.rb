class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user])
    post = Post.find(params[:post])
    like = Like.new(user: user, post: post)

    if like.save
      redirect_to posts_path

    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:user])
    post = Post.find(params[:post])
    like = Like.find_by(user: user, post: post)

    if like.destroy
      redirect_to posts_path

    else
      render :index, status: :unprocessable_entity
    end
  end
end
