require 'spec_helper'

describe IndexController do
	it "should redirect to home if user is already logged in" do
		user = FactoryGirl.create(:user)
		session[:user_id] = user.id
		get :index 
		response.should redirect_to(:controller => "home", :action => "index")
	end

	it "should be succesful if the user is not logged in but doesnot redirect" do
		get :index
		expect(response).to be_success
		expect(response).to render_template('index')
	end
end
