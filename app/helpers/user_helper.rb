module UserHelper
	def selected_school sch_id
		st = (sch_id == current_user.school.fb_id) ? "checked" : nil
		return st
	end
end
