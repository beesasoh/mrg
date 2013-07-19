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
end
