class QuestionsController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @question = Question.new
      authorize @question
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @question = @post.questions.new(params.require(:question).permit(:title, :body, :user_id, :resolved))
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
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])    
    @question = Question.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])    
    @question = Question.find(params[:id])
      authorize @question
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id]) 
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
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])     
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