class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment_creation = Action::CommentCreation.new(comment_creation_params.merge(author: current_member))
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment_creation = Action::CommentCreation.new(comment_creation_params.merge(author: current_member))
    @comment = @comment_creation.perform
    if @comment.present?
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_creation_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end