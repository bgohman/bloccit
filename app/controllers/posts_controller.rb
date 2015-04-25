class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @summary = @post.summary
    authorize @post
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
      authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(params.require(:post).permit(:title, :body))
    @post.user = current_user
      authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post.  Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post.  Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
    if @post.destroy
      flash[:notice] = "Post was deleted."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the question.  Please try again."
      redirect_to [@topic, @post]
    end
  end
  
end
