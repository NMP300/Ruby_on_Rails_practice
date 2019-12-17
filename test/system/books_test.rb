# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:Taro)
    login_as(@user)
  end

  test "書籍一覧を表示できる" do
    visit books_path
    assert_selector "h1", text: I18n.t("title.books")
  end

  test "新しく書籍を作成することができる" do
    visit new_book_path

    fill_in I18n.t("activerecord.attributes.book.title"), with: "ジェネラルルージュの凱旋"
    fill_in I18n.t("activerecord.attributes.book.memo"), with: "熱い本だった"
    fill_in I18n.t("activerecord.attributes.book.author"), with: "海堂尊"
    attach_file I18n.t("activerecord.attributes.book.picture"), "#{Rails.root.join('test/fixtures/images/books/book1.jpeg')}"

    assert_difference "Book.count", 1 do
      click_button I18n.t("helpers.submit.create")
    end
  end

  test "作成済みの書籍の詳細ページを表示することができる" do
    visit book_path(id: books(:book1).id)

    assert_selector "h1", text: I18n.t("title.books_detail")
  end

  test "作成済みの書籍を編集することができる" do
    visit edit_book_path(id: books(:book1).id)

    fill_in I18n.t("activerecord.attributes.book.title"), with: "イノセントゲリラの祝祭"
    fill_in I18n.t("activerecord.attributes.book.memo"), with: "カッコ良かった"
    fill_in I18n.t("activerecord.attributes.book.author"), with: "海堂尊"
    attach_file I18n.t("activerecord.attributes.book.picture"), "#{Rails.root.join('test/fixtures/images/books/book2.jpeg')}"

    click_button I18n.t("helpers.submit.update")

    assert_text I18n.t('successfully.Book_was_successfully_updated.')
  end

  test "作成済みの書籍を削除することができる" do
    visit books_path

    assert_difference "Book.count", -1 do
      page.accept_confirm do
        click_link I18n.t("link.destroy")
      end
      sleep 3
    end
  end
end
