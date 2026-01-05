class FollowsController < ApplicationController
  def create
    @followed = User.find(params[:followed_id])
    current_user.being_follower.build(followed: @followed)

    if current_user.save
      redirect_to users_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    follower = User.find(params[:follower_id])
    followed = User.find(params[:followed_id])
    follow = Follow.find_by(follower: follower, followed: followed)
    follow.accepted!
    redirect_to users_path
  end

  def destroy
    follower = User.find(params[:follower_id])
    followed = User.find(params[:followed_id])
    follow = Follow.find_by(follower: follower, followed: followed)

    if follow.destroy
      redirect_to users_path
    else
      render :index, status: :unprocessable_entity
    end
  end
end
