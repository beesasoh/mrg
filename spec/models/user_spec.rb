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
    before :each do
      @user = FactoryGirl.build(:user)
    end
  	it " has many games played" do
  		@user.should respond_to(:games_played)
  	end

  	it " has many courses/favourites" do
  		@user.should respond_to(:courses)
  	end

    it " reponds to badges" do
      @user.should respond_to(:badges) 
    end
  end

  describe "Methods" do

    pending "first_name"
    pending "first_and_last_name"

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
      user3 = FactoryGirl.create(:user)

      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id)
      expect(user1.rank).to eq(2)
      expect(user2.rank).to eq(1)
      expect(user3.rank).to eq(nil)
    end

    it "rank_today should return the current user's rank Today" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)

      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
      game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
      game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.days.ago)

      expect(user1.rank_today).to eq(1)
      expect(user2.rank_today).to eq(2)
      expect(user3.rank_today).to eq(nil)
    end

    it "rank_this_week should return the current user's rank of the week" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)

      game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.weeks.ago)
      
      expect(user1.rank_this_week).to eq(1)
      expect(user2.rank_this_week).to eq(2)
      expect(user3.rank_this_week).to eq(nil)
    end

    it "next_up with num returns the id of the user who is num positions above the current user in rankings" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id)
      FactoryGirl.create(:game, :score => 40, :user_id => user3.id)

      expect(user1.next_up(4)).to eq(nil)
      expect(user3.next_up(1)).to eq(user1.id)
      expect(user3.next_up(2)).to eq(user2.id)
      expect(user1.next_up).to eq(user2.id)
      expect(user4.next_up).to eq(nil)
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
      expect(user3.next_down).to eq(nil)
    end

    it "next_up_today with num returns the id of the user who is num positions above the current user in rankings today" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => 2.weeks.ago)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 40, :user_id => user3.id,:created_at => 2.days.ago)

      expect(user1.next_up_today(4)).to eq(nil)
      expect(user3.next_up_today(1)).to eq(nil)
      expect(user2.next_up_today).to eq(user1.id)
      expect(user4.next_up_today).to eq(nil)
    end

    it "next_down_today with num returns the id of the user who is num positions below the current user in rankings today" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => 2.weeks.ago)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 40, :user_id => user3.id,:created_at => 2.days.ago)

      expect(user1.next_down_today(4)).to eq(nil)
      expect(user3.next_down_today(1)).to eq(nil)
      expect(user2.next_down_today(1)).to eq(nil)
      expect(user1.next_down_today).to eq(user2.id)
    end

    it "next_up_this_week with num returns the id of the user who is num positions above the current user in rankings this week" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => 2.weeks.ago)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 60, :user_id => user3.id,:created_at => Date.today)

      expect(user3.next_up_this_week(4)).to eq(nil)
      expect(user2.next_up_this_week(2)).to eq(user3.id)
      expect(user2.next_up_this_week).to eq(user1.id)
      expect(user4.next_up_this_week).to eq(nil)
    end

    it "next_down_this_week with num returns the id of the user who is num positions below the current user in rankings this week" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)

      FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => 2.weeks.ago)
      FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => Date.today)
      FactoryGirl.create(:game, :score => 60, :user_id => user3.id,:created_at => Date.today)

      expect(user3.next_down_this_week(4)).to eq(nil)
      expect(user2.next_down_this_week).to eq(nil)
      expect(user3.next_down_this_week).to eq(user1.id)
      expect(user3.next_down_this_week(2)).to eq(user2.id)
      expect(user4.next_down_this_week).to eq(nil)
    end

    it "get_pivot_array takes a rankings array and returns the current user position with the next 2 users up and down" do
      user = FactoryGirl.create(:user)
      rankings_array = ['a','b','c','d','e','f']
        expect(user.get_pivot_array(rankings_array)).to eq(nil)
      rankings_array = [1,2,user.id]
        expect(user.get_pivot_array(rankings_array)).to eq(rankings_array)
      rankings_array = [user.id,2,3,4,5,6,7,8,9]
        expect(user.get_pivot_array(rankings_array)).to eq([user.id,2,3,4,5])
      rankings_array = [1,2,3,4,5,6,7,8,user.id]
        expect(user.get_pivot_array(rankings_array)).to eq([5,6,7,8,user.id])
      rankings_array = [1,2,3,4,user.id,6,7,8,9]
        expect(user.get_pivot_array(rankings_array)).to eq([3,4,user.id,6,7])
    end

    pending "stats"
    pending "num_games_played"
    pending "num_games_played_subject"
    pending "performance"
    pending "performance_in_subject"
    pending "performance_in_course"
    pending "performance_last_7_days"
    pending "badges_array"
    pending "has_badge?"
    pending "has_no_badge?"

  end
end
