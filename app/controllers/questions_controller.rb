class QuestionsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @question = Question.new
    authorize @question
  end

  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @question = @post.questions.new(params.require(:question).permit(:title, :body, :user_id, :resolved))
    @question.user = current_user
    authorize @question

    if @question.save
      flash[:notice] = "Question was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the question.  Please try again."
      render :new
    end    
  end

  def show
    @post = Post.find(params[:post_id]) 
    @topic = @post.topic   
    @question = Question.find(params[:id])
  end

  def edit
    @post = Post.find(params[:post_id])  
    @topic = @post.topic  
    @question = Question.find(params[:id])
    authorize @question
  end

  def update
    @post = Post.find(params[:post_id]) 
    @topic = @post.topic
    @question = Question.find(params[:id])
    authorize @question
    if @question.update_attributes(params.require(:question).permit(:title, :body, :resolved))
      flash[:notice] = "Question was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the question.  Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])  
    @topic = @post.topic   
    @question = Question.find(params[:id])
    authorize @question
    if @question.destroy
      flash[:notice] = "Question was deleted."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the question.  Please try again."
      redirect_to [@topic, @post]
    end  
  end

end