class QuestionsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @question = Question.new
    authorize @question
  end

  def create
    @post = Post.find(params[:post_id])
    @question = current_user.questions.build( question_params )
    @question.post = @post
    @new_question = Question.new
    authorize @question
    #if @question.save
    #  flash[:notice] = "Question was saved."
    #else
    #  flash[:error] = "There was an error saving the question.  Please try again."
    #end
    @question.save
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
    else
      flash[:error] = "There was an error deleting the question.  Please try again."
    end
    respond_to do |format|
      format.html
      format.js
    end  
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

end