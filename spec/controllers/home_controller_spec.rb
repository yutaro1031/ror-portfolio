require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    it '正常なレスポンスか' do
      get :index
      expect(response).to be_successful
    end

    it "200レスポンスが返ってくるか" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'indexテンプレートをレンダリングしているか' do
      get :index
      expect(response).to render_template :index
    end
  end
end