require 'spec_helper'

describe Question do
	before(:each) do
		@question = FactoryGirl.build(:question)
	end
  describe "Validation" do
  	it "should be valid given the correct attributes" do
  		@question.should be_valid
  	end

  	[:question, :course_id].each do |item|
  		it "#{item} must be present" do
  			@question[item] = ""
  			@question.should_not be_valid
  			@question.errors[item].should_not be_blank
  		end
  	end

  	it "should save without explanation" do
  		@question.explanation = ""
  		@question.should be_valid
  		@question.errors[:explanation].should be_blank
  	end

  	it "should save without an image" do
  		@question.image = nil
  		@question.should be_valid
  		@question.errors[:image].should be_blank
  	end
  end

  describe "Associations" do
  	[:course, :choices].each do |item|
  		it "should respond to #{item}" do 
  			@question.should respond_to(item)
  		end
  	end
  end

end
