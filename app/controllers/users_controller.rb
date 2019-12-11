# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @posts = Book.where(user_id: @user) + Report.where(user_id: @user)
    @posts.sort_by! { |post| post[:created_at] }
  end
end
