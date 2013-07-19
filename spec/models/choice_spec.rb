require 'spec_helper'

describe Choice do
	before(:each) do
		@choice = FactoryGirl.build(:choice)
	end

	describe "Validations" do 
		[:choice, :question_id].each do |item|
			it "#{item} should be present" do
				@choice[item] = ""
				@choice.should_not be_valid
			end
		end

		it "Should be valid given correct attributes" do
			@choice.should be_valid
		end
	end

	describe "Associations" do
		it "responds to question" do
			@choice.should respond_to(:question)
		end
	end
end
