require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    it "正常なレスポンスか" do
      get :index
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it ':indexテンプレートをレンダリングしているか' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before do
      user = FactoryBot.create(:user, :admin_user)
      @article = FactoryBot.create(:article, user: user)
    end

    it "正常なレスポンスか" do
      get :show, params: { id: @article }
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      get :show, params: { id: @article }
      expect(response).to have_http_status(:success)
    end

    it ":indexテンプレートをレンダリングしているか" do
      get :show, params: { id: @article }
      expect(response).to render_template :show
    end

    it "@articleが期待される値を持つ" do
      get :show, params: { id: @article }
      expect(assigns(:article)).to eq @article
    end
  end

  describe "GET #new" do
    it "302レスポンスが返ってくるか(管理者)" do
      user = FactoryBot.create(:user, :admin_user)
      login_user user
      get :new
      expect(response).to have_http_status "302"
    end

    it "404レスポンスが返ってくるか(非管理者)" do
      user_not_admin = FactoryBot.create(:user)
      login_user user_not_admin
      get :new
      expect(response).to have_http_status "404"
    end

  end

  describe "POST #create" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end
