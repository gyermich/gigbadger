require 'spec_helper'

describe UsersController do
 include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end


  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
end

