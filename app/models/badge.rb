class Badge < ActiveRecord::Base
  attr_accessible :description, :name ,:image

  has_and_belongs_to_many :users

  has_attached_file :image #, :styles => {:thumb => "220x140"} , :default_url => "images/missing_sub.jpg"

  validates_presence_of :name , :description

  WELCOME_BADGE_ID = 1
  FAST_AND_ACCURATE_BADGE_ID = 2
  WINTER_BADGE_ID = 3
  CHILLER_BADGE_ID = 4
  FACEBOOK_FUN_BADGE_ID = 5
  ROYAL_BADGE_ID = 6
  FRIENDLY_BADGE_ID = 7
  DAY_STAR_BADGE_ID = 8
  WEEEK_STAR_BADGE_ID = 9
  KASAZO_BADGE_ID = 10
  ON_ALERT_BADGE_ID = 11
  BEERA_MU_CLASS_BADGE_ID = 12

  def self.get_earned_badges(score , user)
  	badges_earned = []
  	user_badges = user.badges_array

  	badges_earned << WELCOME_BADGE_ID if user.has_no_badge?(WELCOME_BADGE_ID) && earned_welcome?(user)
  	badges_earned << FAST_AND_ACCURATE_BADGE_ID if user.has_no_badge?(FAST_AND_ACCURATE_BADGE_ID) && earned_fast_and_accurate?(score,user)
    badges_earned << CHILLER_BADGE_ID if user.has_no_badge?(CHILLER_BADGE_ID) && earned_chiller?(user)
    badges_earned << ROYAL_BADGE_ID if user.has_no_badge?(ROYAL_BADGE_ID) && earned_royal?(user)
    badges_earned << KASAZO_BADGE_ID if user.has_no_badge?(KASAZO_BADGE_ID) && earned_kasazo?(user)
    badges_earned << ON_ALERT_BADGE_ID if user.has_no_badge?(ON_ALERT_BADGE_ID) && earned_onAlert?(user)
    badges_earned << BEERA_MU_CLASS_BADGE_ID if user.has_no_badge?(BEERA_MU_CLASS_BADGE_ID) && earned_beeraMuClass?(user)

    # *******pending***********
    # winter
    # facebook_fun
    # friendly
    # day star
    # week star


  	return badges_earned
  end

  def self.earned_welcome? user
  	number_of_games_played = user.games_played.size
  	if number_of_games_played >= 5
  		badge = find WELCOME_BADGE_ID
  		user.badges << badge
  		return true
  	else
  		return false
  	end
  end

  def self.earned_fast_and_accurate? score , user
  	if score.to_i > 95
  		badge = find FAST_AND_ACCURATE_BADGE_ID
  		user.badges << badge
  		return true
  	else
  		return false
  	end
  end

  def self.earned_chiller? user
    user_scores = Game.where(:user_id => user.id).pluck(:score)
    scores_less_than_20 = user_scores.select{|score| score < 20}
    if scores_less_than_20.size >= 5
      badge = find CHILLER_BADGE_ID
      user.badges << badge
      return true
    else
      return false
    end
  end

  def self.earned_royal? user
    if user.num_games_played >= 1000
      badge = find ROYAL_BADGE_ID
      user.badges << badge
      return true
    else
      return false
    end
  end

  def self.earned_kasazo? user 
    last_20_scores = Game.where(:user_id => user.id).order("updated_at desc").limit(20).pluck(:score)
    score_less_than_80 = last_20_scores.find{|score| score < 80}
    if score_less_than_80.nil?
      badge = find KASAZO_BADGE_ID
      user.badges << badge
      return true
    else
      return false
    end
  end

  def self.earned_onAlert?(user)
   games_played_today = Game.where(:created_at => Date.today).size
     if games_played_today == 1
      badge = find ON_ALERT_BADGE_ID
      user.badges << badge
      return true
    else
      return false
    end
  end

  def self.earned_beeraMuClass?(user)
    week_peformance = user.performance_last_7_days.map{|item| item[1]}
    if week_peformance.include? 0 
      return false
    else
      badge = find BEERA_MU_CLASS_BADGE_ID
      user.badges << badge
      return true
    end
  end

end
