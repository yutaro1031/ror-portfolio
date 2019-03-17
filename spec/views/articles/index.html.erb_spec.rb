 require 'rails_helper'

 RSpec.describe "articles/index", type: :view do
   # 【メモ】
   # FactoryBot → テストデータを生成してくれるライブラリ
   # createメソッド → 単一のレコード生成、第二引数にtraitを指定することで他のバリエーションを用意可能
   # create_listメソッド → 複数のレコードを生成してくれる
   # ・第3引数にはbelongs_toに対応するオブジェクトを指定できる
  before do
    user = FactoryBot.create(:user, :admin_user)
    FactoryBot.create_list(:article, 50, user: user)
    @articles = Article.where(del_flg: FALSE)
    @articles = @articles.page(params[:page])
    @popular_articles = Article.where(del_flg: false).order(:pv).limit(5)
  end

  it "ページネーションが表示されているか" do
    render

    expect(rendered).to have_css '.pagination'
  end
end
