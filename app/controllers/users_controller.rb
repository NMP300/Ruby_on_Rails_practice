# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.page params[:page]
  end

  def show
    # 改善点：冗長な記述
    @user = User.find(params[:id])
    @posts = []
    @books = Book.where(user_id: @user.id)
    @reports = Report.where(user_id: @user.id)
    @posts << @books
    @posts << @reports
    @posts.flatten!.sort_by! { |post| post[:created_at] }
  end
end
