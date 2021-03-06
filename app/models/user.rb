class User < ActiveRecord::Base

  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid , :email , :image , :coins , :level , :school_id , :motto

  validates_presence_of :name, :oauth_expires_at, :oauth_token, :provider, :uid , :email , :coins , :level
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  has_and_belongs_to_many :courses
  has_and_belongs_to_many :badges
  has_many :games_played , :class_name => "Game",:dependent => :destroy
  belongs_to :school
  
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

  def first_name
    self.name.split(" ")[0]
  end

  def first_and_last_name
    names = self.name.split(" ")
    names.length <= 2 ? "#{names[0]} #{names[1]}" : "#{names[0]} #{names[2]}"
  end

  def linked_image size
    img = "<a href='/user/index/#{self.id}'><img src='http://graph.facebook.com/#{self.uid}/picture?width=#{size}&height=#{size}' /></a>"
    return img.html_safe
  end 

  def get_friends #returns the user's friends who are also registerd on the app
    app_users = User.pluck(:uid)
    graph = Koala::Facebook::API.new(self.oauth_token)
    friends_hash_array = graph.get_connections("me", "friends")
    user_fb_friends = []
    friends_hash_array.each do |friend_hash|
      user_fb_friends << friend_hash["id"]
    end
    return app_users & user_fb_friends
  end

  def get_friends_not_registered_on_app
    @app_users = User.pluck(:uid)
    graph = Koala::Facebook::API.new(self.oauth_token)
    friends_hash_array = graph.get_connections("me", "friends")
    friends_hash_array.select {|friend|  @app_users.include?(friend["id"])==false}
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
    user_postion_in_zero_indexed_array = Game.rankings.keys.index(self.id)
    nil || user_postion_in_zero_indexed_array + 1 if !user_postion_in_zero_indexed_array.nil?
  end

  def rank_today
    user_postion_in_zero_indexed_array = Game.rankings_today.keys.index(self.id)
    nil || user_postion_in_zero_indexed_array + 1 if !user_postion_in_zero_indexed_array.nil?
  end

  def rank_this_week
    user_postion_in_zero_indexed_array = Game.rankings_this_week.keys.index(self.id)
    nil || user_postion_in_zero_indexed_array + 1 if !user_postion_in_zero_indexed_array.nil?
  end

  def rank_in_friends 
    user_postion_in_zero_indexed_array = Game.friends_ranking(self).keys.index(self.id)
    nil || user_postion_in_zero_indexed_array + 1 if !user_postion_in_zero_indexed_array.nil?
  end

  def next_up positions_up=1
    return nil if (current_user_rank = self.rank) == nil 
    Game.rank(current_user_rank-positions_up) if current_user_rank > positions_up && positions_up >= 0
  end

  def next_down positions_down=1
    return nil if (current_user_rank = self.rank) == nil 
    return nil if Game.rankings.size < current_user_rank + positions_down
    Game.rank(current_user_rank + positions_down) if positions_down >= 0
  end

  def next_up_today positions_up=1
    return nil if (current_user_rank = self.rank_today) == nil 
    Game.rank_today(current_user_rank-positions_up) if current_user_rank > positions_up && positions_up >= 0
  end

  def next_down_today positions_down=1
    return nil if (current_user_rank = self.rank_today) == nil 
    return nil if Game.rankings_today.size < current_user_rank+positions_down
    Game.rank_today(current_user_rank+positions_down) if positions_down >= 0
  end

  def next_up_this_week positions_up=1
    return nil if (current_user_rank = self.rank_this_week) == nil 
    Game.rank_this_week(current_user_rank-positions_up) if current_user_rank > positions_up && positions_up >= 0
  end

  def next_down_this_week positions_down=1
    return nil if (current_user_rank = self.rank_this_week) == nil 
    return nil if Game.rankings_this_week.size < current_user_rank+positions_down
    Game.rank_this_week(current_user_rank+positions_down) if positions_down >= 0
  end

  def get_pivot_array ranking_array
    return nil if (current_user_index = ranking_array.index(self.id)) == nil
    ranking_array_size = ranking_array.size
    return ranking_array if ranking_array_size <= 5
    if [0,1,2].index(current_user_index) != nil
      return ranking_array[0..4]
    elsif (ranking_array_size - current_user_index) <= 3
      return ranking_array[(ranking_array_size-5)..(ranking_array_size-1)]
    else
      return ranking_array[(current_user_index-2)..(current_user_index+2)]
    end
  end

  def post_to_wall message
    graph = Koala::Facebook::API.new(self.oauth_token)
    graph.put_connections("me", "feed", 
                      :message => message,
                      :link => "http://myrevisionguide.com/pages/subjects.html")
  end

  def stats
    Game.where(:user_id => self.id).group(:subject_id).sum(:score)
  end

  def num_games_played
    Game.where(:user_id => self.id).count
  end

  def num_games_played_subject subject_id
    Game.where(:user_id => self.id, :subject_id => subject_id).count
  end

  def performance num_games = 50
    Game.select("score,updated_at")
        .where(:user_id => self.id)
        .limit(num_games)
        .order("updated_at desc")
        .reverse
        .each_with_index
        .map{|game, index| [index+1 ,game.score]}
  end

  def performance_in_subject subject_id, num_games = 50
    Game.select("score,updated_at,subject_id")
    .where(:user_id => self.id, :subject_id => subject_id)
    .limit(num_games)
    .order("games.updated_at desc")
    .reverse
    .each_with_index
    .map{|game, index| [index+1 ,game.score]}
  end

  def performance_in_course course_id , num_games=50 
    Game.select("score,updated_at,course_id")
        .where(:user_id => self.id, :course_id => course_id)
        .limit(num_games)
        .order("games.updated_at desc")
        .reverse
        .each_with_index
        .map{|game, index| [index+1 ,game.score]}
  end

  def performance_last_7_days
    perfomance = []
    days = 6
      7.times do
        date = Date.today - days
        score = Game.where(:user_id => self.id, :created_at => date).sum(:score)
        perfomance << [date.strftime("%A"), score]
        days = days - 1
      end
      return perfomance
  end

  def pie_chart_peformance
    @str = '['
    arr = ActiveRecord::Base.connection.exec_query(
      "SELECT SUM(`games`.`score`) AS sum_score, 
      subjects.name FROM `games` INNER JOIN `subjects` ON `subjects`.`id` = `games`.`subject_id` 
      WHERE `games`.`user_id` = #{self.id} GROUP BY subject_id;").to_a

    arr.each do |rec|
        sbj_name = rec["name"]
        sbj_score = rec["sum_score"].to_i
       @str += '{label: "'+ sbj_name +'", data: '+sbj_score.to_s+'},'
    end

    @str += ']'

    return @str

  end

  def badges_array
    self.badges.map{|badge| badge.id}
  end

  def has_badge?(badge_id)
    return badges_array.include?(badge_id)
  end

  def has_no_badge?(badge_id)
    !has_badge?(badge_id)
  end

end
