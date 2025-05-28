class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id]) 
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to posts_path, status: :see_other, notice: "Post was successfully created!"
		else
			flash.now[:errors] = "There was an error creating your post."
			render 'new', status: :unprocessable_entity
		end
	end

	def edit
		@post = Post.find(params[:id])
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

	private
	def post_params
		params.expect(post: [:title, :body, :image_url])
	end
end
