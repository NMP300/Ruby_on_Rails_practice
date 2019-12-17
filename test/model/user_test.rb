# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:Taro)
    @user2 = users(:Hanako)
  end

  test "登録済みのユーザーをomniauth認証情報から発見することができる" do
    auth_params = OmniAuth::AuthHash.new(uid: "12345", provider: "github")
    auth_user = User.from_omniauth(auth_params)
    assert auth_user == @user1
  end

  test "user1がuser2をフォローすることができる" do
    @user1.follow(@user2)
    assert_includes(@user1.following, @user2)
  end

  test "user1がuser2をフォローしている時、user2のフォローを解除することができる" do
    @user1.follow(@user2)
    @user1.unfollow(@user2)
    assert_not_includes(@user1.following, @user2)
  end

  test "user1がuser2をフォローしている時、user1のfollowingの中にuser2がいることを確認できる" do
    @user1.follow(@user2)
    assert @user2 = @user1.following?(@user2)
  end
end
