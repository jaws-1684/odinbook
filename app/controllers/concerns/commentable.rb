module Commentable
	extend ActiveSupport::Concern
	include ActionView::RecordIdentifier
	include RecordHelper

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user = current_user
		@comment.parent_id = @parent&.id

		respond_to do |format|
			if @comment.save
				comment = Comment.new
				format.turbo_stream {
					if @parent
						render turbo_stream: turbo_stream.replace(dom_id_form_records(@parent, comment), 
							partial: "comments/form", 
							locals: {comment: comment, 
							commentable: @parent, 
							data: {comment_reply_target: :form}, class: "hidden"})
					else 
						render turbo_stream: turbo_stream.replace(dom_id_form_records(@commentable, comment), partial: "comments/form", locals: {comment: comment, commentable: @commentable})
					end
				}
				format.html { redirect_to @commentable }
			else
				format.turbo_stream {
					render turbo_stream: turbo_stream.replace(dom_id_form_records(@parent || @commentable, @comment), partial: "comments/form", locals: {comment: @comment, commentable: @parent || @commentable})
				}
				format.html {redirect_to @commentable}
			end	

		end
	end

	private

	def comment_params
		params.expect(comment: [:body])
	end
end