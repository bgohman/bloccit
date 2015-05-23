class PostsController < ApplicationController
  def index
    @posts = Post.visible_to(current_user).where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 10)
    random_ids = Advertisement.all.sort_by { rand }.slice(0, 3)
    @advertisements = Advertisement.where(:id => random_ids)
    @posts_and_advertisements = (@posts + @advertisements).sort_by(&:created_at)
  end



end