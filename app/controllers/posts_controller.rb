class PostsController < ApplicationController
	layout "feed"
	before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
	
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
        format.html { redirect_to posts_path, notice: 'Post created successfully!' }
      end
    else  	
      respond_to do |format|
	    format.turbo_stream { render turbo_stream: turbo_stream.replace('new_post', partial: 'posts/form', locals: { post: @post }) }
	    format.html { render :new, status: :unprocessable_entity }
  		end
    end
  end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to posts_path, status: :see_other, notice: "Post was successfully updated!"
		else
			flash.now[:errors] = "There was an error updating your post."
			render 'new', status: :unprocessable_entity
		end	
	end

	def destroy
		@post.destroy
		flash[:success] = "Post was successfully deleted!"

		redirect_to root_path, status: :see_other
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
		params.expect(post: [:title, :body, :image_url])
	end
end
