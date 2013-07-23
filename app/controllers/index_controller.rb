class IndexController < ApplicationController
	layout 'index'
	def index
		if current_user
			redirect_to(:controller => "home", :action => "index")
		end
	end
end
