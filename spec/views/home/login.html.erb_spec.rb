require 'rails_helper'

RSpec.describe "home/login", type: :view do

  it "flashが表示されるか" do
    flash[:error_messages] = ["test"]

    render
    expect(rendered).to have_selector 'li', text: "test"
  end
end
