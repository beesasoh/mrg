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

    it "rank should return the current user global position" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id)
      expect(user1.rank).to eq(2)
      expect(user2.rank).to eq(1)
    end

    it "rank_today should return the current user's rank Today" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
      game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
      game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.days.ago)
      expect(user1.rank_today).to eq(1)
      expect(user2.rank_today).to eq(2)
    end

    it "rank_this_week should return the current user's rank of the week" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.weeks.ago)
      expect(user1.rank_this_week).to eq(1)
      expect(user2.rank_this_week).to eq(2)
    end

    it "next_up with num returns the id of the user who is num positions above the current user in rankings" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id)
      FactoryGirl.create(:game, :score => 40, :user_id => user3.id)

      expect(user1.next_up(4)).to eq(nil)
      expect(user3.next_up(1)).to eq(user1.id)
      expect(user3.next_up(2)).to eq(user2.id)
      expect(user1.next_up).to eq(user2.id)
    end

    it "next_down with num returns the id of the user who is num positions below the current in rankings" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id)
      FactoryGirl.create(:game, :score => 40, :user_id => user3.id)

      expect(user1.next_down(4)).to eq(nil)
      expect(user2.next_down(1)).to eq(user1.id)
      expect(user2.next_down(2)).to eq(user3.id)
      expect(user1.next_down).to eq(user3.id)
    end

  end
end
