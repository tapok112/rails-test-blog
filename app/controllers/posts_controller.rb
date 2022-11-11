class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	POSTS_PER_PAGE = 15
	before_action :find_post, only: [ :show, :edit, :update, :destroy ]
	before_action :page_num, only: [ :user_posts_list, :index ]

	def index
		@pages_count = (Post.count(:all).to_f / POSTS_PER_PAGE).ceil
		@posts = Post.offset((@page-1) * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
	end

	def user_posts_list
		@pages_count = (current_user.posts.size.to_f / POSTS_PER_PAGE).ceil
		@posts = current_user.posts.offset((@page-1) * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
		render :index
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		if title_check && @post.save
			redirect_to @post, success: 'Пост создан'
		else
			flash.now[:danger] = 'Пост не создан'
			render :new
		end
	end
	
	def edit
		unless @post.user_id == current_user.id
    	redirect_to post_path(@post), danger: 'Невозможно изменить'
		end
	end

	def update		
		if (title_check || post_params.value?(@post.title)) && @post.update(post_params) && @post.user_id == current_user.id
			redirect_to @post, success: 'Пост обновлен'
		else
			flash.now[:danger] = 'Пост не обновлен'
			render :edit
		end
	end

	def destroy
		if @post.user_id == current_user.id
			@post.destroy
			redirect_to posts_path, success: 'Пост удален'
		else
			redirect_to posts_path, danger: 'Пост не удален'
		end
	end

	private

	def page_num
		@page = params.fetch(:page, 1).to_i
	end

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
