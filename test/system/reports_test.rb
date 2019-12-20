# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:Taro)
    login_as(@user)
  end

  test "書籍一覧を表示できる" do
    visit reports_path
    assert_selector "h1", text: I18n.t("title.reports")
  end

  test "新しく日報を作成することができる" do
    visit new_report_path

    fill_in I18n.t("activerecord.attributes.report.title"), with: "初めてのレポート"
    fill_in I18n.t("activerecord.attributes.report.text"), with: "今日は頑張った"
    attach_file I18n.t("activerecord.attributes.book.picture"), "#{Rails.root.join('test/fixtures/images/reports/report1.jpeg')}"

    assert_difference "Report.count", 1 do
      click_button I18n.t("helpers.submit.create")
    end
  end

  test "作成済みの日報の詳細ページを表示することができる" do
    visit report_path(id: reports(:report1).id)

    assert_selector "h1", text: I18n.t("title.report_detail")
  end

  test "作成済みの日報を編集することができる" do
    visit edit_report_path(id: reports(:report1).id)

    fill_in I18n.t("activerecord.attributes.report.title"), with: "編集したレポート"
    fill_in I18n.t("activerecord.attributes.report.text"), with: "編集したテキスト"
    attach_file I18n.t("activerecord.attributes.report.pictures"), "#{Rails.root.join('test/fixtures/images/reports/report2.jpeg')}"

    click_button I18n.t("helpers.submit.update")

    assert_text I18n.t("successfully.Report_was_successfully_updated.")
  end

  test "作成済みの日報を削除することができる" do
    visit reports_path

    assert_difference "Report.count", -1 do
      page.accept_confirm do
        click_link I18n.t("link.destroy")
      end
      sleep 3
    end
  end
end
