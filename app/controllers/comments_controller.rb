class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post

    authorize! :create, @comment, message: "You must be signed in to comment"

    if @comment.save
      flash[:notice] = "Your comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Didn't save. Please try again."
      render "posts/show"
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    if @comment.destroy
      flash[:notice] = "Comment deleted."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment not deleted, please try again."
      redirect_to [@topic, @post]
    end
  end
end
