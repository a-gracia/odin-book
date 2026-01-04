class FollowsController < ApplicationController
  def create
    @followed = User.find(params[:followed_id])
    current_user.following << @followed
  end
end
