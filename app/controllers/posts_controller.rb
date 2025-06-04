class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
	def index
		@posts = Post.all
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
    @post = current_user.posts.build(post_params)
    
    respond_to do |format|
      if @post.save
        format.turbo_stream
        format.html { redirect_to posts_path, notice: 'Post created successfully!' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

	def edit
	end

	def update
		@post = Post.find(params[:id])

		if @post.update
			redirect_to posts_path, status: :see_other, notice: "Post was successfully updated!"
		else
			flash.now[:errors] = "There was an error updating your post."
			render 'new', status: :unprocessable_entity
		end	
	end

	def destroy
		@post = Post.find(params[:id])
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
