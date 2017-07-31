require 'spec_helper'

describe Badge do
	describe "validation " do
		[:name, :description].each do |item|
  		it "#{item} should not be blank " do 
  			badge = FactoryGirl.build(:badge, item => '')
  			badge.should_not be_valid
  			badge.errors[item].should_not be_blank
  		end
  	end
	end

	describe "Associations" do
		it "should respond to users" do
			badge = FactoryGirl.build(:badge)
			badge.should respond_to(:users)
		end
	end

	describe "methods" do
		it "earned_royal? should return true if the user has earned the badge" do
			ROYAL_BADGE_ID = 6
			user = FactoryGirl.create(:user)
			badge = FactoryGirl.create(:badge, :id=> ROYAL_BADGE_ID)
			999.times do
				game = FactoryGirl.create(:game, :user_id => user.id)
			end
			expect(Badge.earned_royal?(user)).to eq(false)
			game = FactoryGirl.create(:game, :user_id => user.id)
			expect(Badge.earned_royal?(user)).to eq(true)
			expect(user.badges_array.include?(ROYAL_BADGE_ID)).to eq(true)

		end

		it "earned_kasazo? should return true if the user has earned this badge" do
			KASAZO_BADGE_ID = 10
			user = FactoryGirl.create(:user)
			badge = FactoryGirl.create(:badge, :id=> KASAZO_BADGE_ID)

			20.times { game = FactoryGirl.create(:game, :score=>70, :user_id => user.id) }
			expect(Badge.earned_kasazo?(user)).to eq(false)
			19.times { game = FactoryGirl.create(:game, :score=>80, :user_id => user.id) }
			expect( Badge.earned_kasazo?(user) ).to eq(false)
			20.times { game = FactoryGirl.create(:game, :score=>80, :user_id => user.id) }
			expect( Badge.earned_kasazo?(user) ).to eq(true)
			expect(user.badges_array.include?(KASAZO_BADGE_ID)).to eq(true)
		end

		it "earned_chiller? should return true if user has scored below 20 for 5 times" do
			CHILLER_BADGE_ID = 4
			user = FactoryGirl.create(:user)
			badge = FactoryGirl.create(:badge, :id=> CHILLER_BADGE_ID)
			5.times { game = FactoryGirl.create(:game, :score=>70, :user_id => user.id) }
			expect(Badge.earned_chiller?(user)).to eq(false)
			5.times { game = FactoryGirl.create(:game, :score=>7, :user_id => user.id) }
			expect(Badge.earned_chiller?(user)).to eq(true)
			expect(user.badges_array.include?(CHILLER_BADGE_ID)).to eq(true)
		end

		it "earned_onAlert? returns true if user has played the first game on any day" do
			ON_ALERT_BADGE_ID = 11
			Game.delete_all

			badge = FactoryGirl.create(:badge, :id=> ON_ALERT_BADGE_ID)
			user1 = FactoryGirl.create(:user)
			user2 = FactoryGirl.create(:user)
			FactoryGirl.create(:game,:user_id => user2.id ,:created_at => 2.days.ago)
			FactoryGirl.create(:game,:user_id => user1.id) 
			FactoryGirl.create(:game,:user_id => user2.id)

			expect(Badge.earned_onAlert?(user1)).to eq(true)
			expect(Badge.earned_onAlert?(user2)).to eq(true)
			expect(user1.badges_array.include?(ON_ALERT_BADGE_ID)).to eq(true)

		end

		it "earned_beeraMuClass? return true if user has played at least 1 game in the past 7 days" do
			
			BEERA_MU_CLASS_BADGE_ID = 12

			badge = FactoryGirl.create(:badge, :id=> BEERA_MU_CLASS_BADGE_ID)
			user = FactoryGirl.create(:user)
			date = Date.today 
			FactoryGirl.create(:game,:user_id => user.id ,:created_at => date - 6)
			FactoryGirl.create(:game,:user_id => user.id ,:created_at => date - 5)
			FactoryGirl.create(:game,:user_id => user.id ,:created_at => date - 4)
			FactoryGirl.create(:game,:user_id => user.id ,:created_at => date - 3)
			FactoryGirl.create(:game,:user_id => user.id ,:created_at => date - 2)
			FactoryGirl.create(:game,:user_id => user.id ,:created_at => date - 1)
			FactoryGirl.create(:game,:user_id => user.id, :created_at => Date.today)

			expect(user.performance_last_7_days.map{|item| item[1]}).to eq([50,50,50,50,50,50,50])
			expect(Badge.earned_beeraMuClass?(user)).to eq(true)
			expect(user.badges_array.include?(BEERA_MU_CLASS_BADGE_ID)).to eq(true)

		end
		pending "get_earned_badges"
		pending "earned_welcome?"
		pending "earned_fast_and_accurate?"
	end
end
