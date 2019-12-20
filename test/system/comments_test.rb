# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:Taro)
    login_as(@user)
  end

  test "書籍のコメント一覧を表示できる" do
    visit book_path(id: books(:book1).id)

    assert_text I18n.t("activerecord.models.comment")
  end

  test "日報のコメント一覧を表示できる" do
    visit report_path(id: reports(:report1).id)

    assert_text I18n.t("activerecord.models.comment")
  end

  test "書籍にコメントを新規投稿できる" do
    visit book_path(id: books(:book1).id)

    fill_in "comment_text", with: "面白い本だった"

    assert_difference "Comment.count", 1 do
      click_button I18n.t("activerecord.attributes.comment.post_comment")
    end
  end

  test "日報にコメントを新規投稿できる" do
    visit report_path(id: reports(:report1).id)

    fill_in "comment_text", with: "よく頑張った"

    assert_difference "Comment.count", 1 do
      click_button I18n.t("activerecord.attributes.comment.post_comment")
    end
  end

  test "書籍のコメントを編集することができる" do
    visit edit_comment_path(id: comments(:comment1).id)

    fill_in "comment_text", with: "良い本編集"

    click_button I18n.t("activerecord.attributes.comment.post_comment")

    assert_text I18n.t("successfully.Comment_was_successfully_updated.")
  end

  test "日報のコメントを編集することができる" do
    visit edit_comment_path(id: comments(:comment1))

    fill_in "comment_text", with: "よく頑張った編集"

    click_button I18n.t("activerecord.attributes.comment.post_comment")

    assert_text I18n.t("successfully.Comment_was_successfully_updated.")
  end

  test "書籍のコメント削除することができる" do
    visit book_path(id: books(:book1).id)

    assert_difference "Comment.count", -1 do
      page.accept_confirm do
        click_on I18n.t("link.destroy")
      end
      sleep 1
    end
  end

  test "日報のコメントを削除することができる" do
    visit report_path(id: reports(:report1).id)

    assert_difference "Comment.count", -1 do
      page.accept_confirm do
        click_on I18n.t("link.destroy")
      end
      sleep 1
    end
  end
end
