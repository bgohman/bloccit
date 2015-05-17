class TopicsController < ApplicationController
  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def show
    @topic = Topic.find(params[:id])
    random_ids = Advertisement.all.sort_by { rand }.slice(0, 3)
    @advertisements = Advertisement.where(:id => random_ids)
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
    @posts_and_advertisements = (@posts + @advertisements).sort_by(&:created_at)
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
      authorize @topic
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic.  Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
      authorize @topic
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic.  Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic.  Please try again."
      redirect_to @topic
    end
  end

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

end
