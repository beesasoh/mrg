require 'spec_helper'

describe SubjectController do
	before(:each) do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
	end
	describe "GET :index" do
		it "should be successful" do
			get :index
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "renders the list templates" do
			get :index
			expect(response).to render_template("list")
		end
	end

	describe "GET :list" do
		it "should be successful" do
			get :list
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "renders the list templates" do
			get :list
			expect(response).to render_template("list")
		end 

		it "assigns :subjects" do
			get :list
			assigns[:subjects].should == Subject.all
		end
	end

	describe "GET :quizzes" do 
		before(:each) do
			@subject = FactoryGirl.create(:subject)
		end
		it "should be successful and must have the params id" do
			get :quizzes , :id => @subject.id
			controller.params[:id].should_not be_nil
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "renders the quiz template" do
			get :quizzes , :id => @subject.id
			expect(response).to render_template("quiz")
		end

		it "assigns :subject using the passed in Id" do 
			get :quizzes, :id => @subject.id
			assigns[:subject].should == Subject.find(@subject.id)
		end
	end
end
