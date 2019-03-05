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
    render_404 unless current_user && current_user.admin_flg
    @article = Article.new(
                          user_id: current_user.id,
                          title: "無題の記事",
                          text: "ここに本文を入力してください",
                          publish_flg: FALSE
    )
    # あらかじめinsertしておく
    unless @article.save
      flash[:alert] = "記事の作成に失敗しました"
      redirect_to articles_path
    end

    redirect_to edit_article_path @article
  end

  def edit
    render_404 unless current_user && current_user.admin_flg
  end

  def update
    # 下書き保存
    if @article.update_attributes(tmp_article_params)
      render json: {result: "ok"}
    else
      render json: {result: "error"}
    end
  end

  # def create
  #   article = Article.new(article_params)
  #   if article.save
  #     flash[:notice] = "「#{article.title}」の記事を作成しました"
  #     redirect_to articles_path
  #   else
  #     redirect_to new_article_path, flash: {
  #         article: article,
  #         alert: "記事の作成に失敗しました"
  #     }
  #   end
  # end



  private

  def set_target_article
    @article = Article.find(params[:id])
    render_404 if @article.del_flg # 削除された記事は404
  end

  def article_params
    # フォームの構造を変えた時、permitするparamも変える
    params.require(:article).permit(:user_id, :title, :text, :eyecatch, :tmp_title, :tmp_text, :tmp_eyecatch, :remove_eyecatch, :remove_tmp_eyecatch, tag_ids: [])
  end

  def tmp_article_params
    params = article_params
    params = change_params_to_tmp(params, 'title') if params[:title]
    params = change_params_to_tmp(params, 'text') if params[:text]
    params
  end

  def change_params_to_tmp(params, col_name)
    params["tmp_#{col_name}".to_sym] = params[col_name.to_sym]
    params.delete(col_name)
    params
  end

end