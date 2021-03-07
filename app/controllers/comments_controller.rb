class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :verify_comment_owner, only: %i[destroy].freeze

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = 'Comment saved.'
    else
      flash[:danger] = 'Your comment could not be saved.'
    end

    redirect_to @comment.issue
  end

  def destroy
    @issue = Issue.find_by(id: params[:issue_id])

    if @comment.destroy
      flash[:success] = 'Your comment was deleted.'
    else
      flash[:danger] = "Your comment couldn't be deleted."
    end

    redirect_to @issue
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def verify_comment_owner
    return if @comment.user == current_user

    flash[:danger] = "You can't perform that action."
  end

  def comment_params
    params.require(:comment).permit(:issue_id, :user_id, :content)
  end
end
