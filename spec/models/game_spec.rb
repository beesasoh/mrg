require 'spec_helper'

describe Game do
	before(:each) do
		@game = FactoryGirl.build(:game)
	end
  describe "Validation" do 
	  	[:score, :subject_id, :user_id, :course_id].each do |item|
	  		it "#{item} can not be blank" do
		  		@game[item] = ""
		  		@game.should_not be_valid
		  		@game.errors[item].should_not be_blank
		  	end
	  	end

	  	it "Should save given the correct attributes" do
	  		@game.should be_valid
	  	end 
  end

  describe "Associations" do
  	[:user, :course, :subject].each do |item|
  		it "responds to #{item}" do 
  			@game.should respond_to(item)
  		end
  	end
  end

end
