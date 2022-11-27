# Контроллер комментариев
class CommentsController < ApplicationController
  # Фильтр требующий авторизацию перед запуском экшенов
  before_action :authenticate_user!
  # Фильтр поиска поста перед запуском экшенов create и destroy
  before_action :find_post, only: %i[create destroy]

  # Создание комментария
  def create
    @comment = @post.comments.create(comment_params)
    @comment.assign_attributes(user_id: current_user.id)

    if @comment.save

      redirect_to post_path(@post), success: 'Комментарий прикреплен'
    else

      redirect_to post_path(@post), danger: 'Комментарий не прикреплен'
    end
   
  end

  # Удаление комментария
  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.destroy

      redirect_to post_path(@post), success: 'Комментарий удален'
    else

      redirect_to post_path(@post), danger: 'Комментарий не удален'
    end

  end

  private

  # Параментры при создании комментария
  def comment_params
    params.require(:comment).permit(:body)
  end

  # Поиск поста которому принадлежит коммениарий
	def find_post
		@post = Post.find(params[:post_id])
	end
end
