class PostsController < ApplicationController
  def index
    @posts=Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post=Post.new
    authorize! :create, Post, message: "You need to be a member to create a new post."
  end

  def create
    @post = current_user.posts.build(params[:post])
    authorize! :create, Post, message: "You need to be a member to create a new post."

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
    authorize! :update, Post, message: "You need to be the post's dickhead to edit it"
  end

  def update
    @post = Post.find(params[:id])
    authorize! :update, Post, message: "You need to be the post's dickhead to edit it"
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end
end
