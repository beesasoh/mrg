module UserHelper
	def selected_school sch_id
		return nil if current_user.school.nil?
		st = (sch_id == current_user.school.fb_id) ? "checked" : nil
		return st
	end
end
