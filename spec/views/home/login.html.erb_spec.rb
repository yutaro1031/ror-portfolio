require 'rails_helper'

RSpec.describe "home/login", type: :view do

  it "flashが表示されるか" do
    flash[:error_messages] = ["test"]

    render
    expect(rendered).to have_selector 'li', text: "test"
  end
end

# フィーチャースペック
 RSpec.describe "ログインとログアウト", type: :feature do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログインする' do
    visit authenticate_path

    fill_in 'ユーザー名', with: @user.name
    fill_in 'パスワード', with: @user.password

    find(".btn-primary").click

    expect(page).to have_content 'test1 さん、こんにちは!'
  end
 end