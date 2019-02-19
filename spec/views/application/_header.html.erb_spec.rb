require 'rails_helper'

RSpec.describe "application/_header", type: :view do

  it "未ログイン時のヘッダーの表示" do
    render
    expect(rendered).to have_selector '.dropdown-item', text: "登録"
    expect(rendered).to have_selector '.dropdown-item', text: "ログイン"
  end

  it "ログイン時のヘッダーの場合(非管理者)" do
    user = FactoryBot.create(:user)
    login_user user

    render
    expect(rendered).to have_selector '.dropdown-item', text: "マイページ"
    expect(rendered).to have_selector '.dropdown-item', text: "ログアウト"
    expect(rendered).not_to have_selector '.btn', text: "記事作成"
  end

  it "ログイン時のヘッダーの場合(管理者)" do
    user_admin = FactoryBot.create(:user, :admin_user)
    login_user user_admin

    render
    expect(rendered).to have_selector '.dropdown-item', text: "マイページ"
    expect(rendered).to have_selector '.dropdown-item', text: "ログアウト"
    expect(rendered).to have_selector '.btn', text: "記事作成"
  end
end
