class PostsController < ApplicationController
	before_action :authenticate_user!, except: %i[index show]
	before_action :find_post, only: %i[show edit update destroy]
	before_action :page_num, only: %i[user_posts_list index]

	def index
		if params[:user]
			@posts = Post.by_user(params[:user]).page params[:page]
		else
			@posts = Post.page params[:page]
		end
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		if @post.save
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
		if @post.user_id == current_user.id && @post.update(post_params)
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

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :body, :image)
	end
end
