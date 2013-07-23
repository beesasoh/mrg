require 'spec_helper'

describe PlayController do
	before(:each) do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
	end

	describe "GET :index" do
		it "assigns course" do
			course = FactoryGirl.create(:course)
			get :index, :id => course.id
			assigns[:course].should == course
		end
	end

	describe "create" do
		it "Get request should not process and should return dont be a hero" do
			course = FactoryGirl.create(:course)
			get :create , :course => course.id, :score => 30

			re = Hash.new
			re["message"] = "dont be a hero"
			
			response.body.should == re.to_json
		end
	end
end
