class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    @comments = @user.comments
    @questions = @user.questions
    @comments_and_questions = (@questions + @comments).sort_by &:created_at
    random_ids = Advertisement.all.sort_by { rand }.slice(0, 3)
    @advertisements = Advertisement.where(:id => random_ids)
    @posts_and_advertisements = (@posts + @advertisements).sort_by(&:created_at)
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :email_favorites)
  end

  
end
