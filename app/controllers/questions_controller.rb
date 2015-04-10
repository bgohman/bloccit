class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @post = Post.find(params[:post_id])
    @question = Question.new
  end

  def create
    @question = Question.new(params.require(:question).permit(:title, :body, :resolved))
    if @question.save
      flash[:notice] = "Question was saved."
      redirect_to @question
    else
      flash[:error] = "There was an error saving the question.  Please try again."
      render :new
    end    
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params.require(:question).permit(:title, :body, :resolved))
      flash[:notice] = "Question was updated."
      redirect_to @question
    else
      flash[:error] = "There was an error saving the question.  Please try again."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    if @question.destroy
      flash[:notice] = "Question was deleted."
      redirect_to questions_path
    else
      flash[:error] = "There was an error deleting the question.  Please try again."
      redirect_to @question
    end  
  end

end