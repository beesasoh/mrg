module RankingsHelper

	def print_rankings rank_arr
		html = ''
		html << '<div id = "rankings-list">'
		html << '<ul>'

		rank_arr.each do |user_id|
			user = User.find(user_id)
			html << '<li>'
			html << "<div class='rank-item'>"
				html << "<div class = 'rank-image'>"
				html <<	"<img src='http://graph.facebook.com/#{user.uid}/picture?width=100&height=100' />"
				html << '</div>'

				html << "<div class = 'rank-info'>"
				html <<	"<div class ='rank-name'>#{user.first_and_last_name[0..22]}</div>"
					html << "<div class = 'rank-school'>#{(user.school.nil? ? "no school": user.school.name)}</div>"
					html << "<div class = 'rank-marks'>points: #{user.points}</div>"
					html << "<div class = 'rank-position'>#{user.rank}</div>"
				html << '</div>'
				html << '<div class = "clear-fix"></div>'
			html << "</div>"
			html << "</li>"
		end

		html << "</ul>"
		html << '<div class = "clear-fix"></div>'
		html << "</div>"

		return html.html_safe
	end

	def print_friends_rankings rank_arr
		html = ''
		html << '<div id = "rankings-list">'
		html << '<ul>'

		rank_arr.each do |user_id|
			user = User.find(user_id)
			html << '<li>'
			html << "<div class='rank-item'>"
				html << "<div class = 'rank-image'>"
				html <<	"<img src='http://graph.facebook.com/#{user.uid}/picture?width=100&height=100' />"
				html << '</div>'

				html << "<div class = 'rank-info'>"
				html <<	"<div class ='rank-name'>#{user.first_and_last_name[0..22]}</div>"
					html << "<div class = 'rank-school'>Mugwanya summit college kyengera</div>"
					html << "<div class = 'rank-marks'>points: #{user.points}</div>"
					html << "<div class = 'rank-position'>#{user.rank}</div>"
				html << '</div>'
				html << '<div class = "clear-fix"></div>'
			html << "</div>"
			html << "</li>"
		end

		html << "</ul>"
		html << '<div class = "clear-fix"></div>'
		html << "</div>"

		return html.html_safe
	end

	def print_rankings_today rank_arr
		html = ''
		html << '<div id = "rankings-list">'
		html << '<ul>'

		rank_arr.each do |user_id|
			user = User.find(user_id)
			html << '<li>'
			html << "<div class='rank-item'>"
				html << "<div class = 'rank-image'>"
				html <<	"<img src='http://graph.facebook.com/#{user.uid}/picture?width=100&height=100' />"
				html << '</div>'

				html << "<div class = 'rank-info'>"
				html <<	"<div class ='rank-name'>#{user.first_and_last_name[0..22]}</div>"
					html << "<div class = 'rank-school'>Mugwanya summit college kyengera</div>"
					html << "<div class = 'rank-marks'>points: #{user.points_today}</div>"
					html << "<div class = 'rank-position'>#{user.rank_today}</div>"
				html << '</div>'
				html << '<div class = "clear-fix"></div>'
			html << "</div>"
			html << "</li>"
		end

		html << "</ul>"
		html << '<div class = "clear-fix"></div>'
		html << "</div>"

		return html.html_safe
	end

	def print_rankings_this_week rank_arr
		html = ''
		html << '<div id = "rankings-list">'
		html << '<ul>'

		rank_arr.each do |user_id|
			user = User.find(user_id)
			html << '<li>'
			html << "<div class='rank-item'>"
				html << "<div class = 'rank-image'>"
				html <<	"<img src='http://graph.facebook.com/#{user.uid}/picture?width=100&height=100' />"
				html << '</div>'

				html << "<div class = 'rank-info'>"
				html <<	"<div class ='rank-name'>#{user.first_and_last_name[0..22]}</div>"
					html << "<div class = 'rank-school'>Mugwanya summit college kyengera</div>"
					html << "<div class = 'rank-marks'>points: #{user.points_this_week}</div>"
					html << "<div class = 'rank-position'>#{user.rank_this_week}</div>"
				html << '</div>'
				html << '<div class = "clear-fix"></div>'
			html << "</div>"
			html << "</li>"
		end

		html << "</ul>"
		html << '<div class = "clear-fix"></div>'
		html << "</div>"

		return html.html_safe
	end

end
