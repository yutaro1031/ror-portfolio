class ArticlesController < ApplicationController
  # 各アクションの実行前にset_target_articleが実行されるように指定
  before_action :set_target_article, only: %i[show edit update destroy]

  def index # 記事一覧を表示
    @articles = Article.where(del_flg: FALSE)
    @articles = @articles.page(params[:page])
  end

  def show # 記事詳細画面

  end

  private

  def article_params
    # 余分なparamを排除する
  end

  def set_target_article
    @article = Article.find(params[:id])
    render_404 if @article.del_flg # 削除された記事は404
  end

end