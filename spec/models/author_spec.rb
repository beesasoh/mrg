require 'spec_helper'

describe Author do
	before(:each) { @author = FactoryGirl.build(:author)}

	describe "Validations" do
		it "should save given correct attributes" do
			@author.should be_valid
		end

		[:email,:name].each do |item|
			it "must have #{item}" do
				@author[item] = ""
				@author.should_not be_valid
				@author.errors[item].should_not be_blank
			end
		end

		it "should validate email" do
			@author.email = "invalid_email"
			@author.should_not be_valid
			@author.errors[:email].should_not be_blank
		end
	end

	describe "Associations" do
		it "should respond to courses" do
			@author.should respond_to(:courses)
		end
	end
end
