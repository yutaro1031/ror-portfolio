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
      user = FactoryBot.create(:user)
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
      expect(assigns(:article)).to eq @article
    end
  end

  describe "GET #new" do
    # 【メモ】
    # sessionは追加できたが、404を返すメソッドが「application_controller」に定義されている
    # よって、レスポンスの判断ができない

    it "正常なレスポンスか" do
      # session = { "admin_flg": FALSE }
      # add_session(session)
      get :new
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      # session = { "admin_flg": FALSE }
      # add_session(session)
      get :new
      expect(response).to have_http_status(:success)
    end

    # it "404レスポンスが返ってくるか(非管理者)" do
    #   get :new
    #   session[:admin_flg] = FALSE
    #   expect(response).to have_http_status "404"
    # end

    it ':newテンプレートをレンダリングしているか' do
      get :new
      expect(response).to render_template :new
    end
  end

end
