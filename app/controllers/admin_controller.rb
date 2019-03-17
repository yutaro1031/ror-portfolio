class AdminController < ApplicationController
  def index
    render_404 unless current_user.admin_flg
  end
end