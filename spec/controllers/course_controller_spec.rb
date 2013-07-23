require 'spec_helper'

describe CourseController do
	before(:each) do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
	end
	describe "GET :index" do
		it "should be successful and renders list template" do
			get :index
			expect(response).to be_success
			expect(response.status).to eq (200)
			expect(response).to render_template("list")
		end
	end

	describe "GET :list" do
		it "should be successful" do
			get :list
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "renders the correct template" do
			get :list
			expect(response).to render_template("list")
		end

		it "assigns the courses" do
			get :list
			assigns[:courses].should == Course.all
		end
	end
end
