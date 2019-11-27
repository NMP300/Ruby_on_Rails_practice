# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page params[:page]
    render 'show_follow'
  end
end
