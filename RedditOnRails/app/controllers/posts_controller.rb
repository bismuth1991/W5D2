class PostsController < ApplicationController
  before_action :require_author, only: [:edit]

  def new
    render :new
  end

  def create
    debugger
    post = Post.new(post_params)
    post.author_id = current_user.id
    post.sub_id = params[:post][:sub_id]

    if post.save
      redirect_to sub_url(post.sub_id)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to new_sub_post_url
    end
  end

  def edit
    render :edit
  end

  def update
    post = Post.find(params[:id])
    
    if post.update(post_params)
      redirect_to post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to edit_post_url(post)
    end
  end

  def show
    @post = Post.find(params[:id])

    if @post
      render :show
    else
      redirect_to subs_url
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def require_author
    @post = Post.find(params[:id])

    if @post.author_id != current_user.id
      flash[:errors] = ["You are not authorized to edit this post!"]
      redirect_to post_url(@post)
    end
  end
end
