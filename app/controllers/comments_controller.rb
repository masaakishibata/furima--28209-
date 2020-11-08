class CommentsController < ApplicationController

  def new
    @comments = Comment.all
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(text: params[:comment] [:text])
    Comment.create(comment_params)
  end

  private

  def comment_params
    params.requier(:comment).permit(:text).merge(
      user_id: current_user.id,
      item_id: params[:item_id]
    )

end
