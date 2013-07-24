class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid , :email , :image , :coins , :level

  validates_presence_of :name, :oauth_expires_at, :oauth_token, :provider, :uid , :email , :coins , :level
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  has_and_belongs_to_many :courses
  has_many :games_played , :class_name => :game ,:dependent => :destroy
  
  
  def self.create_user_from(auth)
  	where(auth.slice(:provider , :uid)).first_or_initialize.tap do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
  		user.name = auth.info.name
  		user.email = auth.info.email
  		user.image = auth.info.image
  		user.coins = 0
  		user.level = 1
  		user.oauth_token = auth.credentials.token
  		user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  		user.save!
  	end
  end

  def points
    Game.where(:user_id => self.id).sum(:score)
  end

  def points_today
    Game.where(:user_id => self.id, :created_at => Date.today).sum(:score)
  end

  def points_this_week
    Game.where(:user_id => self.id, 
                :created_at => Date.today.at_beginning_of_week..Date.today.at_end_of_week).sum(:score)
  end

  def rank
    Game.rankings.keys.index(self.id) + 1
  end

  def rank_today
    Game.rankings_today.keys.index(self.id) + 1
  end

  def rank_this_week
    Game.rankings_this_week.keys.index(self.id) + 1
  end

  def next_up positions_up=1
    current_user_rank = self.rank 
    if current_user_rank <= positions_up || positions_up < 0
      return nil
    else
      Game.rank(current_user_rank-positions_up)
    end
  end

  def next_down positions_down=1
    current_user_rank = self.rank 
    if positions_down < 0
      return nil
    else
      Game.rank(current_user_rank + positions_down)
    end
  end

  def next_up_today num=1
  end

  def next_down_today num=1
  end

  def next_up_this_week num=1
  end

  def next_down_this_week num=1
  end

end
