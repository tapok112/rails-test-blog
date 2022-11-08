class PostsController < ApplicationController
	before_action :find_post, only: [ :show, :edit, :update, :destroy ]

	def index
		@posts = Post.all
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if title_check && @post.save
			redirect_to @post, success: 'Пост создан'
		else
			flash.now[:danger] = 'Пост не создан'
			render :new
		end
	end
	
	def edit
	end

	def update		
		if (title_check || post_params.value?(@post.title)) && @post.update(post_params)
			redirect_to @post, success: 'Пост обновлен'
		else
			flash.now[:danger] = 'Пост не обновлен'
			render :edit
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, success: 'Пост удален'
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def title_check
		!Post.find_by(title: @post.title)
	end

	def post_params
		params.require(:post).permit(:title, :body, :post_image)
	end
end
