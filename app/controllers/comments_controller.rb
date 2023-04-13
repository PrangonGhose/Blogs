class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @user.posts.find(params['post_id'])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@user, @post) }
      else
        format.html { render :new }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @post.comments_counter -= 1
    @comment.destroy
    redirect_to user_post_path(@user, @post)
  end
end
