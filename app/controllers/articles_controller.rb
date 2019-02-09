class ArticlesController < ApplicationController
  before_action :set_target_article # 各アクションの実行前にset_target_articleが読み込まれるように指定

  def index # 記事一覧を表示
    # あとでdel_flgの判定を加える
    @articles = Article.page(params[:page])
  end

  def show

  end

  private

  def article_params
    # 余分なparamを排除する
  end

  def set_target_article
    @article = Article.find(params[:id])
  end

end