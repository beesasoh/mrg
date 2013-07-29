module PlayHelper

	def displayFirstQuestion(num)
		"first" if num == 1
	end

	def play_print_rankings rank_array
		html = ''
		html << '<div class="rank-wrapper">'
        html <<	"<h3>Rankings</h3>"

        rank_array.each do |user_id|
        	user = User.find(user_id)
	        html << "<div class='r-item'>"
		        html << "<div class='u-rank'>#{user.rank}</div>"   	
		        html << "<div class='u-img'><img src='http://graph.facebook.com/#{user.uid}/picture?width=70&height=70' /></div>"
		        html << "<div class='u-name'> #{user.first_name}</div>"
		        html << "<div class='u-points'>#{user.points}</div>"      
	        html <<  "</div>"
        end
        	html << "<div class='clear-fix'></div>"	
        	html << "<div class='fb-share'><a class ='share' href='#' title = 'is number #{current_user.rank} with #{current_user.points} points at my revision guide'>share on facebook</a></div>"
         html << '</div>'
         return html.html_safe
	end

	def play_print_rankings_today rank_array
		html = ''
		html << '<div class="rank-wrapper">'
        html <<	"<h3>Rankings today</h3>"

        rank_array.each do |user_id|
        	user = User.find(user_id)
	        html << "<div class='r-item'>"
		        html << "<div class='u-rank'>#{user.rank_today}</div>"   	
		        html << "<div class='u-img'><img src='http://graph.facebook.com/#{user.uid}/picture?width=70&height=70' /></div>"
		        html << "<div class='u-name'> #{user.first_name}</div>"
		        html << "<div class='u-points'>#{user.points_today}</div>"      
	        html <<  "</div>"
        end
        	html << "<div class='clear-fix'></div>"
        	html << "<div class='fb-share'><a class ='share' href='#' title = 'is number #{current_user.rank_today} today with #{current_user.points_today} points at my revision guide'>share on facebook</a></div>"	
         html << '</div>'
         return html.html_safe
	end

	def play_print_rankings_this_week rank_array
		html = ''
		html << '<div class="rank-wrapper">'
        html <<	"<h3>Rankings this week</h3>"

        rank_array.each do |user_id|
        	user = User.find(user_id)
	        html << "<div class='r-item'>"
		        html << "<div class='u-rank'>#{user.rank_this_week}</div>"   	
		        html << "<div class='u-img'><img src='http://graph.facebook.com/#{user.uid}/picture?width=70&height=70' /></div>"
		        html << "<div class='u-name'> #{user.first_name}</div>"
		        html << "<div class='u-points'>#{user.points_this_week}</div>"      
	        html <<  "</div>"
        end
        	html << "<div class='clear-fix'></div>"	
        	html << "<div class='fb-share'><a class ='share' href='#' title = 'is number #{current_user.rank_this_week} this week with #{current_user.points_this_week} points at my revision guide'>share on facebook</a></div>"
         html << '</div>'
         return html.html_safe
	end

	def play_print_friends_rankings rank_array
		html = ''
		html << '<div class="rank-wrapper">'
        html <<	"<h3>Ranking in friends</h3>"

        rank_array.each do |user_id|
        	user = User.find(user_id)
	        html << "<div class='r-item'>"
		        html << "<div class='u-rank'>#{user.rank}</div>"   	
		        html << "<div class='u-img'><img src='http://graph.facebook.com/#{user.uid}/picture?width=70&height=70' /></div>"
		        html << "<div class='u-name'> #{user.first_name}</div>"
		        html << "<div class='u-points'>#{user.points}</div>"      
	        html <<  "</div>"
        end
        	html << "<div class='clear-fix'></div>"	
        	html << "<div class='fb-share'><a class ='share' href='#' title = 'is number #{current_user.rank_this_week} this week with #{current_user.points_this_week} points at my revision guide'>share on facebook</a></div>"
         html << '</div>'
         return html.html_safe
	end
end
