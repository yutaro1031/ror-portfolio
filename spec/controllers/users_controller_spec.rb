require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #me" do
    it '正常なレスポンスか' do
      get :me
      expect(response).to be_successful
    end

    it '200レスポンスが返ってくるか' do
      get :me
      expect(response).to have_http_status(:success)
    end

    it ':meテンプレートをレンダリングしているか' do
      get :me
      expect(response).to render_template :me
    end
  end
end