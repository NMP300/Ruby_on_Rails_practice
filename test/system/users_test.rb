# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:Taro)
    login_as(@user)
  end

  test "ユーザー一覧を表示できる" do
    visit users_path
    assert_selector "h1", text: I18n.t("title.all_users")
  end

  test "ユーザーを新規登録することができる" do
    logout
    visit new_user_registration_path

    fill_in I18n.t("activerecord.attributes.user.name"), with: "Jiro Takahashi"
    fill_in I18n.t("activerecord.attributes.user.email"), with: "Jiro@example.com"
    fill_in I18n.t("activerecord.attributes.user.postal_code"), with: "0000000"
    fill_in I18n.t("activerecord.attributes.user.address"), with: "日本"
    fill_in I18n.t("activerecord.attributes.user.password"), with: "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: "password"

    attach_file I18n.t("activerecord.attributes.user.icon"), "#{Rails.root.join('test/fixtures/images/users/user1.jpeg')}"

    assert_difference "User.count", 1 do
      click_button I18n.t("link.sign_up")
    end
  end

  test "ユーザーの詳細ページを表示することができる" do
    visit user_path(id: users(:Taro).id)

    assert_selector "h1", text: I18n.t("title.profile")
  end

  test "ログインしているユーザーのプロフィールを編集することができる" do
    visit edit_user_registration_path(id: users(:Taro).id)

    fill_in I18n.t("activerecord.attributes.user.name"), with: "Saburo Tanaka"
    fill_in I18n.t("activerecord.attributes.user.email"), with: "Saburo@example.com"
    fill_in I18n.t("activerecord.attributes.user.postal_code"), with: "1111111"
    fill_in I18n.t("activerecord.attributes.user.address"), with: "アメリカ"

    attach_file I18n.t("activerecord.attributes.user.icon"), "#{Rails.root.join('test/fixtures/images/users/user2.jpeg')}"

    click_button I18n.t("devise.registrations.edit.update")

    assert_text I18n.t("devise.registrations.updated")
  end

  test "ログインしているユーザーを削除することができる" do
    visit edit_user_registration_path(id: users(:Taro).id)

    assert_difference "User.count", -1 do
      page.accept_confirm do
        click_button I18n.t("devise.registrations.edit.cancel_my_account")
      end
      sleep 3
    end
  end
end
