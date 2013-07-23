class SocialController < ApplicationController
	layout 'blank'
	before_filter :confirm_logged_in
  def index
  end
end
