require 'spec_helper'

describe HomeController do
	before(:each) do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
	end
	describe "GET #index" do
		it "it responds sussesfully with status code 200" do
			get :index
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "should render the index template" do
			get :index
			expect(response).to render_template("index")
		end

		it "should assign subjects" do
			get :index
			assigns[:subjects].should == Subject.all
		end

	end

end
