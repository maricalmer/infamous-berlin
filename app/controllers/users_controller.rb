class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]

  def show
    @portfolio = Project.portfolio.where(user_id: @user.id)
  end

  private

  def set_user
    @user = User.find_by(slug: params[:slug])
  end
end
