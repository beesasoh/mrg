require 'spec_helper'

describe Subject do
	before(:each) do
		@subject = FactoryGirl.build(:subject)
	end
  describe "Validations" do
  		it "name should not be blank" do 
  			@subject.name =""
  			@subject.should_not be_valid
  			@subject.errors[:name].should_not be_blank
  		end

  		it "image cant be blank" do
  			@subject.image_thumb = nil
  			@subject.should_not be_valid
  			@subject.errors[:image_thumb].should_not be_blank
  		end

	  	it "should save given the correct attributes" do
	  		@subject.should be_valid
	  	end
  end
end



