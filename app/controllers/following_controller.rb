# frozen_string_literal: true

class FollowingController < ApplicationController
  def index
    @user = User.find(params[:id])
    @users = @user.following.page params[:page]
  end
end
