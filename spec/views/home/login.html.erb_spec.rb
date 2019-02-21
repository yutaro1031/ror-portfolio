require 'rails_helper'

# フィーチャースペック
 RSpec.describe "ログインとログアウト", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @user.confirm
  end

  it "ログインする" do
    visit new_user_session_path

    fill_in "ユーザー名またはメールアドレス", with: @user.name
    fill_in "パスワード", with: @user.password

    find(".btn-primary").click

    expect(page).to have_content "ログインしました。"
  end

  it "ログアウトする" do
    sign_in @user
    visit root_path

    click_link "ログアウト"
    expect(page).to have_content "ログアウトしました。"
  end
 end