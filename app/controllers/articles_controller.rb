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
    case article_params[:update_type]
    when 'tmp' # 下書き保存
      update_article(tmp_article_params)
    when 'publish' # 公開設定(タグもそこで行う)
      update_article(publish_article_params)
    else render json: {result: "error: nothing change_type"}
    end
  end

  def ajax_remove_eyecatch
    # パラメータの値によってtmpか否かを決める
  end

  private

  def set_target_article
    @article = Article.find(params[:id])
    render_404 if @article.del_flg # 削除された記事は404
  end

  def article_params
    # フォームの構造を変えた時、permitするparamも変える
    params.require(:article).permit(:user_id,
                                    :title,
                                    :text,
                                    :eyecatch,
                                    :tmp_title,
                                    :tmp_text,
                                    :tmp_eyecatch,
                                    :publish_flg,
                                    :update_type,
                                    tag_ids: [])
  end

  def tmp_article_params
    params = article_params
    params[:tmp_title] = params[:title] if params[:title]
    params[:tmp_text] = params[:text] if params[:text]
    params.slice(:tmp_title, :tmp_text, :tmp_eyecatch)
  end

  def publish_article_params
    params = article_params
    params[:publish_flg] = ActiveRecord::Type::Boolean.new.cast(params[:publish_flg])
    params[:title] = params[:tmp_title] if params[:tmp_title]
    params[:text] = params[:tmp_text] if params[:tmp_text]
    if params[:tmp_eyecatch]
      @article.remove_eyecatch!
      @article.save
      params[:eyecatch] = params[:tmp_eyecatch]
    end
    params[:tmp_title] = nil
    params[:tmp_text] = nil
    params[:tmp_eyecatch] = nil

    params.except(:update_type)
  end

  def update_article(params)
    if @article.update(params)
      render json: {result: "ok"}
    else
      render json: {result: "error"}
    end
  end

  def remove_eyecatch(tmp)
    if tmp
      @article.remove_tmp_eyecatch!
    else
      @article.remove_eyecatch!
    end
    if @article.save
      render json: {result: "ok"}
    else
      render json: {result: "error"}
    end
  end

end