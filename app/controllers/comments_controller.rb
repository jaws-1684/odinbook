class CommentsController < ApplicationController
	before_action :set_comment

	def show
	end

	def edit
	  respond_to do |format|
	    format.turbo_stream { render partial: "comments/form", locals: { comment: @comment } }
	    format.html 
	  end
	end

	def update
		if @comment.update(comment_params)
			redirect_to @comment
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			format.turbo_stream {}
			format.html {redirect_to @comment.commentable}
		end
	end

	private

		def set_comment
			@comment = current_user.comments.find(params[:id])
		end

		def comment_params
			params.expect(comment: [:body])
		end
end