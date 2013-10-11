class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post

    authorize! :create, :comment, message: "You must be signed in to comment"

    if @comment.save
      flash[:notice] = "Your comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Didn't save. Please try again."
      render "posts/show"
    end
  end
end
