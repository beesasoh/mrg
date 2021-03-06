class Game < ActiveRecord::Base
  attr_accessible :score , :subject_id , :user_id , :course_id

  belongs_to :user
  belongs_to :course
  belongs_to :subject

  validates_presence_of :subject_id, :user_id , :course_id , :score

  def self.rankings lim=0
    return order("sum_score desc").group("games.user_id").sum(:score) if lim == 0
  	order("sum_score desc").group("games.user_id").limit(lim).sum(:score)
  end

  def self.rankings_today lim=0
  	return where(:created_at => Date.today).order("sum_score desc").group("games.user_id").sum(:score) if lim == 0
    where(:created_at => Date.today).order("sum_score desc").group("games.user_id").limit(lim).sum(:score)
  end

  def self.rankings_this_week lim=0
  	return where(:created_at => Date.today.at_beginning_of_week..Date.today.at_end_of_week).order("sum_score desc").group("games.user_id").sum(:score) if lim == 0
    where(:created_at => Date.today.at_beginning_of_week..Date.today.at_end_of_week).order("sum_score desc").group("games.user_id").limit(lim).sum(:score)
  end

  def self.friends_ranking user
    friends = user.get_friends
    friends << user.uid
    joins(:user).where("users.uid" => friends).order("sum_score desc").group("games.user_id").sum(:score)
  end

  def  self.rank num
    if rankings.size < num
      return nil
    else
      rankings.keys[num-1]
    end
  end

  def self.rank_today num
    if rankings_today.size < num
      return nil
    else
      rankings_today.keys[num-1]
    end
  end

  def self.rank_this_week num
    if rankings_this_week.size < num
      return nil
    else
      rankings_this_week.keys[num-1]
    end
  end

end
