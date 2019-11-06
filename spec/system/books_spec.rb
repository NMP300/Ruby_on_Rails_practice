require "rails_helper"

describe "多言語化機能", type: :system do
  describe "新規投稿機能の日本語化" do
    context "新しい書籍情報を登録したとき" do
      before do
        visit "/books"
        click_on "日本語"
        click_on "新規登録"
        fill_in "タイトル", with: "学問のすゝめ"
        fill_in "メモ", with: "読んだことはない"
        fill_in "作者", with: "福沢諭吉"
        click_on "登録する"
      end

      it "フラッシュメッセージが日本語で表示される" do
        expect(page).to have_content "書籍情報の登録に成功しました"
      end
    end
  end

  describe "新規投稿機能の英語化" do
    context "新しい書籍情報を登録したとき" do
      before do
        visit "/books"
        click_on "English"
        click_on "New Book"
        fill_in "Title", with: "The great Gatsby"
        fill_in "Memo", with: "I have not read."
        fill_in "Author", with: "Francis Scott Key Fitzgerald"
        click_on "Create Book"
      end

      it "フラッシュメッセージが英語で表示される" do
        expect(page).to have_content "Book was successfully created"
      end
    end
  end
end