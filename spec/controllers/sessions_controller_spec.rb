require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "正しい場合のリダイレクト先が正しいか" do
      post :create, params: { post: { name: @user.name, password: @user.password } }
      expect(response).to redirect_to articles_path
    end

    it "nameを間違った場合のリダイレクト先が正しいか" do
      post :create, params: { post: { name: "hogehoge", password: @user.password } }
      expect(response).to redirect_to authenticate_path
    end

    it "passwordを間違った場合のリダイレクト先が正しいか" do
      post :create, params: { post: { name: @user.name, password: "hogehoge" } }
      expect(response).to redirect_to authenticate_path
    end
  end
end
