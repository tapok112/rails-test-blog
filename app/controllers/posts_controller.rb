# Контроллер постов
class PostsController < ApplicationController
	# Фильтр требующий авторизацию перед запуском всех экшенов, кроме index и show
	before_action :authenticate_user!, except: %i[index show]
	 # Фильтр поиска поста перед запуском экшенов show, edit, update и destroy
	before_action :find_post, only: %i[show edit update destroy]

	# Список постов
	def index
		@posts = Post.by_user(params[:user_id]).page params[:page]
	end

	# Получение данных поста
	def show
	end

	# Создание шаблона поста для формы
	def new
		@post = Post.new
	end

	# Создание поста
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
	
	# Создание шаблона изменения поста для формы
	def edit

		return if @post.user_id != current_user.id

    redirect_to post_path(@post), danger: 'Невозможно изменить'

	end

	# Изменение поста
	def update
	
		if @post.user_id == current_user.id && @post.update(post_params)
			redirect_to @post, success: 'Пост обновлен'
		else
			flash.now[:danger] = 'Пост не обновлен'

			render :edit
		end

	end

	# Удаление поста
	def destroy

		if @post.user_id == current_user.id
			@post.destroy

			redirect_to posts_path, success: 'Пост удален'
		else

			redirect_to posts_path, danger: 'Пост не удален'
		end

	end

	private

	# Поиск поста для экшенов контроллера
	def find_post
		@post = Post.find(params[:id])
	end

	# Параметры для создания и обновления поста
	def post_params
		params.require(:post).permit(:title, :body, :image)
	end
end
