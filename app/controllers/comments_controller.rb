class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
      authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:title, :body, :resolved))
      authorize @comment

    if @comment.save
      flash[:notice] = "comment was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the comment.  Please try again."
      render :new
    end    
  end

  def show
    @post = Post.find(params[:post_id])    
    @comment = Comment.find(params[:id])
  end

  def edit
    @post = Post.find(params[:post_id])    
    @comment = Comment.find(params[:id])
      authorize @comment
  end

  def update
    @post = Post.find(params[:post_id]) 
    @comment = Comment.find(params[:id])
      authorize @comment
    if @comment.update_attributes(params.require(:comment).permit(:body))
      flash[:notice] = "comment was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the comment.  Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])     
    @comment = Comment.find(params[:id])
      authorize @comment
    @comment.destroy
    if @comment.destroy
      flash[:notice] = "comment was deleted."
      redirect_to @post
    else
      flash[:error] = "There was an error deleting the comment.  Please try again."
      redirect_to @post
    end  
  end

end