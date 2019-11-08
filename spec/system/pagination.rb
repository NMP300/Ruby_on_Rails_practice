require "rails_helper"

describe 'ページネーション表示機能', type: :system do
  it "ページネーションが表示される" do
    50.times { FactoryBot.create(:book) }
    visit "/books"
    expect(page).to have_content '次'
  end
end