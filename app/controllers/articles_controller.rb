class ArticlesController < ApplicationController
  # 各アクションの実行前にset_target_articleが実行されるように指定
  before_action :set_target_article, only: %i[show edit update destroy]
  
  def index # 記事一覧を表示
    @articles = Article.where(del_flg: FALSE)
    @articles = @articles.page(params[:page])
  end

  def show # 記事詳細画面
  end

  def new
    render_404 unless current_user.admin_flg
    @article = Article.new(flash[:article])
  end

  def create
    article = Article.new(article_params)
    if article.save
      flash[:notice] = "「#{article.title}」の記事を作成しました"
      redirect_to articles_path
    else
      redirect_to new_article_path, flash: {
          article: article,
          error_messages: ["記事の作成に失敗しました"]
      }
    end
  end

  private

  def article_params
    params.require(:article).permit(:user_id, :title, :text, tag_ids: [])
  end

  def set_target_article
    @article = Article.find(params[:id])
    render_404 if @article.del_flg # 削除された記事は404
  end

end