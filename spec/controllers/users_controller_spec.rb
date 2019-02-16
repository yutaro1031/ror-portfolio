require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do

    it "正しい場合のリダイレクト先が正しいか" do
      post :create, params: { user: FactoryBot.attributes_for(:user) }
      expect(response).to redirect_to articles_path
    end

    it "nameのバリデーションが効いているか" do
      post :create, params: { user: FactoryBot.attributes_for(:user, name: "asjdfasljfiejfa;sfna;oejfoai") }
      expect(response).to redirect_to new_user_path
    end

    it "passwordのバリデーションが効いているか" do
      post :create, params: { user: FactoryBot.attributes_for(:user, password: "hogehoge") }
      expect(response).to redirect_to new_user_path
    end
  end
end
