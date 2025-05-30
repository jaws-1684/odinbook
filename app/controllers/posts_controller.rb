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
    
    respond_to do |format|
      if @post.save
        format.turbo_stream # This will render create.turbo_stream.erb
        format.html { redirect_to posts_path, notice: 'Post created successfully!' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_post", partial: "new", locals: { post: @post }) }
        format.html { render :new, status: :unprocessable_entity }
      end
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
