module CommentsHelper
	def count_post_comments post
		post.comments.size
	end

end
