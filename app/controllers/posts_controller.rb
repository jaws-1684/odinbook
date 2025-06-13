class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
	before_action :ensure_frame_response, only: [:new, :create, :edit, :update]
	
	def index
		@posts = Post.subscribed_to(current_user)
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
    	respond_to do |format| 
        format.turbo_stream
      end
    else  	
      respond_to do |format|
	    	format.turbo_stream { render turbo_stream: turbo_stream.replace('new_post', partial: 'posts/form', locals: { title: "New Post", post: @post }) }
  		end
    end
  end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:notice] = "Post was successfully updated"
		else
			respond_to do |format|
	    	format.turbo_stream { render turbo_stream: turbo_stream.replace('new_post', partial: 'posts/form', locals: { title: "Edit Post", post: @post }) }
  		end
		end	
	end

	def destroy
		@post.destroy
		flash[:notice] = "Post was successfully deleted!"

		redirect_to posts_path, status: :see_other
	end

	def like
		current_user.likes.create(likeable: @post)
		render partial: "posts/post", locals: { post: @post }
	end

	def unlike
		current_user.likes.find_by(likeable: @post).destroy
		render partial: "posts/post", locals: { post: @post }
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.expect(post: [:title, :body, :image])
	end

	def ensure_frame_response
      return unless Rails.env.development?
      redirect_to root_path unless turbo_frame_request?
  end

end
