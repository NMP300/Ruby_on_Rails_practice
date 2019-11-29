class FollowersController < ApplicationController
  def index
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page params[:page]
  end
end
