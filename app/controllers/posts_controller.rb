class PostsController < ApplicationController
  before_action :require_signin!, except: [:show, :index]
  before_action :find_post, except: [:index, :new, :create]

  def index
    @posts = if current_user
               Post.all
             else
               Post.published
             end
  end

  def new
    @post = Post.new
    @post.user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      flash[:error] = "Failed to create post."
      redirect_to new_post_path
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:error] = "Failed to update post."
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    if params[:commit] == 'Save'
      params.require(:post).permit(:title,
                                   :content,
                                   :author,
                                   :asset,
                                   :tag_names,
                                   :published_at).merge(published_at: Date.today)
    else
      params.require(:post).permit(:title,
                                   :content,
                                   :author,
                                   :asset,
                                   :tag_names,
                                   :published_at).merge(published_at: nil)
    end
  end
end
