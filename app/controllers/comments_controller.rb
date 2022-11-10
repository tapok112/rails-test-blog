class CommentsController < ApplicationController 
  before_action :find_post, only: [ :create, :edit, :update, :destroy ]
    def create
      @comment = @post.comments.create(comment_params)
      if @comment.save
        redirect_to post_path(@post), success: 'Комментарий прикреплен'
      else
        redirect_to post_path(@post), danger: 'Комментарий не прикреплен'
      end      
    end
  
    def destroy
      @post
    end

    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post), success: 'Комментарий удален'
    end

    private

    def comment_params
      params.require(:comment).permit(:user, :body)
    end

	  def find_post
	  	@post = Post.find(params[:post_id])
	  end
end
