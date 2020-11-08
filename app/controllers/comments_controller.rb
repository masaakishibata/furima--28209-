class CommentsController < ApplicationController

  def new
    @comments = Comment.all
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(text: params[:comment] [:text])
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment
    end
    comment = Comment.create(comment_params)
    redirect_to "/items/#{comment.item.id}"
  end

  private

  def comment_params
    params.requier(:comment).permit(:text).merge(
      user_id: current_user.id,
      item_id: params[:item_id]
    )

end
