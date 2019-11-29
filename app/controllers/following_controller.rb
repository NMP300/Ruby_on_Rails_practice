class FollowingController < ApplicationController
  def index
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page params[:page]
  end
end
