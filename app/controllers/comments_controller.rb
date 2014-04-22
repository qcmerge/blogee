class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to @post, notice: "Comment has been saved."
    else
      flash[:error] = "Comment has not been saved."
      render "new"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment has been updated."
    else
      flash[:error] = "Comment has not been updated."
      render "edit"
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment has been deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :author)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])    
  end
end
