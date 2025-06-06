module ApplicationHelper
	def created_by_current_user? resource
		cookies[:current_user_id] == resource.user.id
	end

	def current_user_id
		cookies[:current_user_id] 
	end
end
