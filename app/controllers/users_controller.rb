class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :upcoming_projects, :past_projects, :upcoming_collabs, :past_collabs]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_user_for_projects, only: [:upcoming_projects, :past_projects, :upcoming_collabs, :past_collabs]

  def show
    @past_projects = Project.past.where(user: @user)
    @upcoming_projects = Project.upcoming.where(user: @user)
    @past_collabs = Collab.where(user_id: @user.id).select { |collab| collab.project.past? }
    @upcoming_collabs = Collab.where(user_id: @user.id).select { |collab| collab.project.upcoming? }
    @message = Message.new
  end

  def edit
  end

  def update
    @user.skills = params[:user][:skills].split
    if @user.update(user_params)
      redirect_to dashboard_path, notice: 'Your account was successfully updated.'
    else
      render :edit
    end
  end

  def index
    @users = User.search_by_username_bio_skills_title(params[:query])
    @autocomplete_set = User.first.overall_skill_set
  end

  def upcoming_projects
    @upcoming_projects = Project.upcoming.where(user: @user)
    respond_to do |format|
      format.text { render partial: 'user_upcoming_projects.html' }
    end
  end

  def past_projects
    @past_projects = Project.past.where(user: @user)
    respond_to do |format|
      format.text { render partial: 'user_past_projects.html' }
    end
  end

  def upcoming_collabs
    @upcoming_collabs = Collab.where(user_id: @user.id).select { |collab| collab.project.upcoming? }
    respond_to do |format|
      format.text { render partial: 'user_upcoming_collabs.html' }
    end
  end

  def past_collabs
    @past_collabs = Collab.where(user_id: @user.id).select { |collab| collab.project.past? }
    respond_to do |format|
      format.text { render partial: 'user_past_collabs.html' }
    end
  end

  private

  def set_user
    @user = User.find_by(slug: params[:slug])
  end

  def set_user_for_projects
    @user = User.find_by(slug: params[:user])
  end

  def user_params
    params.require(:user).permit(:email, :username, :bio, :socialmedias, skills: [])
  end
end
