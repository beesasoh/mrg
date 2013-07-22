require 'spec_helper'

describe User do
  describe "Validations" do
  	it "Should be able to create user given `the correct attributes" do
  		user = FactoryGirl.build(:user)
  		user.should be_valid
  	end

  	[:name, :oauth_expires_at, :oauth_token, :provider, :uid , :email , :coins , :level].each do |item|
  		it "#{item} should not be blank " do 
  			user = FactoryGirl.build(:user, item => '')
  			user.should_not be_valid
  			user.errors[item].should_not be_blank
  		end
  	end

  	it "should validate the correct email address format" do
  		user = FactoryGirl.build(:user, :email=>"invalid email")
  		user.should_not be_valid
  		user.errors[:email].should_not be_blank
  	end
  end

  describe "Associations" do 
  	it " has many games played" do
  		user = FactoryGirl.build(:user)
  		user.should respond_to(:games_played)
  	end

  	it " has many courses/favourites" do
  		user = FactoryGirl.build(:user)
  		user.should respond_to(:courses)
  	end
    
  end

end
