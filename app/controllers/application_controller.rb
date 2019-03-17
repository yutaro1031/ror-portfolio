class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from StandardError, with: :resque_exception

  # ストロングパラメータの設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :del_flg, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password])
  end

  # ログイン・ログアウト時のリダイレクト先(deviceのメソッドをオーバーライド)
  def after_sign_in_path_for(resource)
    articles_path
  end

  def after_sign_out_path_for(resource)
    articles_path
  end

  # エラーハンドリング
  def resque_exception(error)
    if error
      logger.info "StandardError!: #{error.message}"
      logger.info error.backtrace.join("\n")
    end
    render_404
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end