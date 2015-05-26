class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new
    authorize @comment 
#    if @comment.save
#      flash[:notice] = "Comment was created."
#    else
#      flash[:error] = "There was an error saving the comment. Please try again."
#    end
    @comment.save
    @questions = @post.questions
    @comments = @post.comments
    @comments_and_questions = (@questions + @comments).sort_by &:created_at


    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:post_id])
    @topic = @post.topic    
    @comment = Comment.find(params[:id])
  end

  def edit
    @post = Post.find(params[:post_id]) 
    @topic = @post.topic   
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @post = Post.find(params[:post_id])
    @topic = @post.topic 
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update_attributes(params.require(:comment).permit(:body))
      flash[:notice] = "comment was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment.  Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic     
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    #if @comment.destroy
    #  flash[:notice] = "Comment was deleted."
    #else
    #  flash[:error] = "There was an error deleting the comment.  Please try again."
    #end 
    respond_to do |format|
      format.html
      format.js
    end 
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end