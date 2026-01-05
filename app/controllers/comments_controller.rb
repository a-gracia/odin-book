class CommentsController < ApplicationController
  def create
    comment = Comment.new(user_id: params[:user_id], post_id: params[:post_id], body: params[:body])

    if comment.save
      redirect_to posts_path
    end
  end
end
