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

  describe "Methods" do
    it "points should return the total points of the user" do
      user = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user.id)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user.id)
      expect(user.points).to eq(50)
    end

    it "points_today should returns the points the user has earned today" do
      user = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user.id ,:created_at => 2.days.ago)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user.id ,:created_at => Date.today)
      expect(user.points_today).to eq(30)
    end
    it "points_this_week should return points the user earned this week" do
      user = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user.id ,:created_at => 2.weeks.ago)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user.id)
      expect(user.points_this_week).to eq(30)
    end
  end

end
