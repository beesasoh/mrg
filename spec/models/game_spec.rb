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

  describe "Methods" do

  	it "rankings returns the global rankings" do
  		user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
    	game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
    	game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
    	game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
   		game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.days.ago)
  		expect(Game.rankings.keys).to eq([user2.id,user1.id])
  	end

  	it "rankings_today returns the rankings of the day" do 
  		user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
    	game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
    	game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
    	game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
   		game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.days.ago)
  		expect(Game.rankings_today.keys).to eq([user1.id,user2.id])
  	end

  	it "rankings_this_week returns the user rankings of the week" do
  		user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
    	game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
    	game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
    	game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
   		game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id, :created_at => 2.weeks.ago)
  		expect(Game.rankings_today.keys).to eq([user1.id,user2.id])
  	end

  	it "rank with num returns the id of the user in position num on global rankings" do
  		user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
    	game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
    	game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
    	game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
   		game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => 2.weeks.ago)
   		expect(Game.rank(10)).to eq(nil)
  		expect(Game.rank(2)).to eq(user1.id)
  	end

  	it "rank_today with num returns the id of the user in position num on todays performance" do
  		user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
    	game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
    	game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
    	game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
   		game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => 2.weeks.ago)
   		expect(Game.rank_today(10)).to eq(nil)
  		expect(Game.rank_today(1)).to eq(user1.id)
  		expect(Game.rank_today(2)).to eq(user2.id)
  	end

  	it "rank_this_week with num returns the id of the user in position num on the week performance" do
  		user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
    	game1 = FactoryGirl.create(:game, :score => 20, :user_id => user1.id,:created_at => Date.today)
    	game2 = FactoryGirl.create(:game, :score => 30, :user_id => user1.id,:created_at => Date.today)
    	game3 = FactoryGirl.create(:game, :score => 20, :user_id => user2.id,:created_at => Date.today)
   		game4 = FactoryGirl.create(:game, :score => 40, :user_id => user2.id,:created_at => 2.weeks.ago)
   		expect(Game.rank_this_week(10)).to eq(nil)
  		expect(Game.rank_this_week(1)).to eq(user1.id)
  		expect(Game.rank_this_week(2)).to eq(user2.id)
  	end

  end

end
