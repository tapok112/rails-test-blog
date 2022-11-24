class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[create edit update destroy]
    def create
      @comment = @post.comments.create(comment_params)
      @comment.assign_attributes(user_id: current_user.id)

      if @comment.save
        redirect_to post_path(@post), success: 'Комментарий прикреплен'
      else
        redirect_to post_path(@post), danger: 'Комментарий не прикреплен'
      end      
    end

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

    def comment_params
      params.require(:comment).permit(:body)
    end

	  def find_post
	  	@post = Post.find(params[:post_id])
	  end
end
