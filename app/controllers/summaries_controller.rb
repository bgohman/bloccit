class SummariesController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @summary = Summary.new
      authorize @summary
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @summary = Summary.new(params.require(:summary).permit(:body))
    @summary.post = @post
      authorize @summary
    if @summary.save
      flash[:notice] = "summary was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the summary.  Please try again."
      render :new
    end    
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])    
    @summary = Summary.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])    
    @summary = Summary.find(params[:id])
      authorize @summary
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id]) 
    @summary = Summary.find(params[:id])
      authorize @summary
    if @summary.update_attributes(params.require(:summary).permit(:body))
      flash[:notice] = "summary was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the summary.  Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])     
    @summary = Summary.find(params[:id])
      authorize @summary
    @summary.destroy
    if @summary.destroy
      flash[:notice] = "summary was deleted."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the summary.  Please try again."
      redirect_to [@topic, @post]
    end  
  end

end