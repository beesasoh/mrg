require 'spec_helper'

describe Course do
	describe "validations" do
		[:title, :level, :cost].each do |item|
			it "should not save if #{item} is blank" do
				course = FactoryGirl.build(:course, item => '')
				course.should_not be_valid
				course.errors[item].should_not be_blank
			end
		end

		it "should not save if cost is not a number" do
			course = FactoryGirl.build(:course, :cost => "not a number")
			course.should_not be_valid
			course.errors[:cost].should_not be_blank
		end

		it "should return valid given the correct attributes" do 
			course = FactoryGirl.build(:course)
			course.should be_valid
		end
	end

	describe "Associations" do
		before (:each) do
			@course = FactoryGirl.build(:course)
		end
		[:author, :subject , :questions, :games_played , :users].each do |item|
			it "should respond to #{item}" do
				@course.should respond_to(item)
			end
		end

		it "can retrieve a subject" do
			subject = FactoryGirl.create(:subject_random)
			@course.subject = subject
			@course.subject.should_not be_nil
			#@course.subject.should be_kind_of(:subject)
		end
	end
end




