class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:post][:name])
    if user && user.authenticate(params[:post][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      redirect_to articles_path #エラーメッセージ
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end