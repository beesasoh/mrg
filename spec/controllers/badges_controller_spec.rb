require 'spec_helper'

describe BadgesController do
	before(:each) do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
	end
	
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
