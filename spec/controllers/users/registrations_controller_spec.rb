require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    user = FactoryBot.create(:user)
    login_user user
  end

  describe "GET #my_page" do
    it '正常なレスポンスか' do
      get :my_page
      expect(response).to be_successful
    end

    it '200レスポンスが返ってくるか' do
      get :my_page
      expect(response).to have_http_status(:success)
    end

    it ':my_pageテンプレートをレンダリングしているか' do
      get :my_page
      expect(response).to render_template :my_page
    end
  end
end