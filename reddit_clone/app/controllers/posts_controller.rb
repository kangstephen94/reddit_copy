class PostsController < ApplicationController

  before_action :require_login, except: [:show]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save!
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    flash[:errors] = @post.errors.full_messages
    redirect_to subs_url
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.delete
    redirect_to sub_url(@post.sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
