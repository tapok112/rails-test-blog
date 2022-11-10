class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	POSTS_PER_PAGE = 15
	before_action :find_post, only: [ :show, :edit, :update, :destroy ]

	def index
		@page = params.fetch(:page, 0).to_i
		@page_qty = (Post.all.size % POSTS_PER_PAGE).ceil
		@posts = Post.offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
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
