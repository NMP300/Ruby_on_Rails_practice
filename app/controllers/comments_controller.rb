# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_created_user, only: [:edit, :update, :destroy]

  def edit
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment.commentable, notice: t("successfully.Comment_was_successfully_created.")
    else
      redirect_to @comment.commentable, notice: t("errors.messages.Comment_was_failure_created.")
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: t("successfully.Comment_was_successfully_updated.")
    else
      render :edit, notice: t("errors.messages.Comment_was_failure_updated.")
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @comment.commentable, notice: t("successfully.Commnet_was_successfully_destroyed.")
    else
      redirect_to @comment.commentable, notice: t("errors.messages.Comment_was_failure_destroyed.")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text, :commentable_type, :commentable_id, :user_id)
  end

  def set_created_user
    @comment = Comment.find_by(id: params[:id], user_id: current_user)
  end
end
