require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # new以外のテストも追加

end
