class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)
    authorize favorite

    if favorite.save
      flash[:notice] = "You've made this post a favorite."
      redirect_to [post.topic, post]
    else
      flash[:error] = "There was an error making this post a favorite.  Please try again."
      render :new
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorited(post)
    authorize favorite

    if favorite.destroy
      flash[:notice] = "This post is no longer a favorite."
      redirect_to [post.topic, post]
    else
      flash[:error] = "There was an error and this post is still a favorite.  Please try again."
      render :new
    end     
  end
end
