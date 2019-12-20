# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:Taro)
    login_as(@user)
  end

  test "フォローしているユーザーの一覧を表示することができる" do
    visit following_index_path(id: users(:Taro).id)

    assert_selector "h1", text: I18n.t("activerecord.attributes.user.following")
  end

  test "フォロワーの一覧を表示することができる" do
    visit followers_path(id: users(:Taro).id)

    assert_selector "h1", text: I18n.t("activerecord.attributes.user.followers")
  end

  test "他のユーザーをフォローすることができる" do
    visit users_path

    click_on "Hanako Sato"

    assert_difference "Follow.count", 1 do
      click_button I18n.t("button.follow")
    end
  end

  test "フォローしているユーザーのフォローを解除することができる" do
    visit user_path(id: users(:Ichiro).id)

    assert_difference "Follow.count", -1 do
      click_button I18n.t("button.unfollow")
    end
  end
end
