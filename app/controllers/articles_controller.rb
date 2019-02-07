class ArticlesController < ApplicationController
  def index # 記事一覧を表示
    # あとでdel_flgの判定を加える
    @articles = Article.page(params[:page])
  end
end