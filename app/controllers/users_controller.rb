class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @portfolio_projects = Project.past.where(user: current_user).order(created_at: :desc)
    @upcoming_projects = Project.upcoming.where(user: current_user).order(created_at: :desc)
    @message = Message.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_path, notice: 'Your account was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(slug: params[:slug])
  end

  def user_params
    params.require(:user).permit(:username, :bio, :skills, :socialmedias)
  end
end
