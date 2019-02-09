class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:post][:name])

    if user && user.authenticate(params[:post][:password])
      session[:user_id] = user.id
      flash[:notice] = "#{user.name} さん、こんにちは!"
      redirect_to articles_path
    else
      redirect_to root_path, flash: {
          error_messages: ["ユーザー名またはパスワードが正しくありません"]
      }
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end