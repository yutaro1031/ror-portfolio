class CommentsController < ApplicationController
  before_action :set_target_comment, only: %i[destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {
          result: "ok",
          user_name: User.find(@comment[:user_id]).name,
          comment: @comment[:text]
      }
    else
      render json: {result: "error"}
    end
  end

  def destroy
    if @comment.destroy
      render json: {
          result: "ok",
          index: params[:format]
      }
    else
      render json: {result: "error"}
    end
  end

  private

  def set_target_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :text)
  end
end
