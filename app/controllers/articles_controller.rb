class ArticlesController < ApplicationController
  # 各アクションの実行前にset_target_articleが実行されるように指定
  before_action :set_target_article, only: %i[show edit update destroy]
  
  def index # 記事一覧を表示
    find_params = {}
    find_params[:del_flg] = false
    find_params[:publish_flg] = true unless current_user && current_user.admin_flg

    if params[:tag_id].present?
      @list_title = "「#{Tag.find(params[:tag_id]).name}」の記事一覧"
      @articles = Tag.find(params[:tag_id]).articles.where(find_params).order(created_at: "DESC")
    elsif params[:q].present?
      @list_title = "「#{params[:q]}」の検索結果"
      @articles = Article.where(find_params).where("title LIKE ?", "%#{params[:q]}%").order(created_at: "DESC")
    else
      @list_title = "新着記事"
      @articles = Article.where(find_params).order(created_at: "DESC")
    end

    @articles = @articles.page(params[:page])
    @popular_articles = Article.where(del_flg: false).order(:pv).limit(5)
  end

  def show # 記事詳細画面
    @article[:pv] += 1
    @article.save

    @popular_articles = Article.where(del_flg: false).order(:pv).limit(5)
  end

  def new
    render_404 and return unless current_user && current_user.admin_flg
    @article = Article.new(
                          user_id: current_user.id,
                          title: "無題の記事",
                          text: "ここに本文を入力してください",
    )
    # あらかじめinsertしておく
    unless @article.save
      flash[:alert] = "記事の作成に失敗しました"
      redirect_to articles_path and return
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
    when 'remove-eyecatch'
      ajax_remove_eyecatch
    else render json: {result: "error: nothing change_type"}
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, alert: "記事を削除しました"
  end

  private

  def set_target_article
    @article = Article.find(params[:id])
    render_404 if @article.del_flg # 削除された記事は404
  end

  def article_params
    params.require(:article).permit(:user_id,
                                    :title,
                                    :text,
                                    :eyecatch,
                                    :tmp_title,
                                    :tmp_text,
                                    :tmp_eyecatch,
                                    :publish_flg,
                                    :pv,
                                    :update_type,
                                    tag_ids: [])
  end

  def tmp_article_params # 下書き保存用のparams
    params = article_params
    params[:tmp_title] = params[:title] if params[:title]
    params[:tmp_text] = params[:text] if params[:text]
    params.slice(:tmp_title, :tmp_text, :tmp_eyecatch)
  end

  def publish_article_params # 記事公開用のparams
    params = article_params
    params[:publish_flg] = ActiveRecord::Type::Boolean.new.cast(params[:publish_flg])
    params[:title] = @article[:tmp_title] if @article[:tmp_title]
    params[:text] = @article[:tmp_text] if @article[:tmp_text]
    if @article[:tmp_eyecatch]
      @article.remove_eyecatch!
      @article.eyecatch = @article.tmp_eyecatch.file
      @article.remove_tmp_eyecatch!
      @article.save
    end
    params[:tmp_title] = nil
    params[:tmp_text] = nil

    params.except(:update_type)
  end

  def update_article(params)
    if @article.update(params)
      render json: {result: "ok"}
    else
      render json: {result: "error"}
    end
  end

  def ajax_remove_eyecatch
    if @article[:tmp_eyecatch]
      result_message = "removed_tmp_eyecatch"
      eyecatch_image_path = @article.eyecatch.to_s# if @article[:eyecatch]
      @article.remove_tmp_eyecatch!
    else
      result_message = "removed_eyecatch"
      @article.remove_eyecatch!
    end
    if @article.save
      render json: {result: result_message, eyecatch_image_path: eyecatch_image_path}
    else
      render json: {result: "error"}
    end
  end

end