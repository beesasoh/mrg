class RankingsController < ApplicationController
 
  before_filter :confirm_logged_in
  def index
  	@rankings = Game.rankings.keys
  end

  def today
  	@today_ranking = Game.rankings_today.keys
  end

  def week
  	@week_ranking = Game.rankings_this_week.keys
  end

  def friends
  	@friends_ranking = Game.friends_ranking(current_user).keys
  end
end
