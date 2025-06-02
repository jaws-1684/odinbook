module ApplicationHelper
	def count_post_comments post
		post.comments.where(commentable_id: post.id).count
	end
end
