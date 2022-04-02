class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :upcoming_projects, :past_projects, :upcoming_collabs, :past_collabs]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_user_for_projects, only: [:upcoming_projects, :past_projects, :upcoming_collabs, :past_collabs, :portfolio, :portfolio_own_projects, :portfolio_collabs, :ongoing_projects, :ongoing_own_projects, :ongoing_collabs]

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
    @user.update(user_params)
    if @user.save
      redirect_to dashboard_path, notice: 'Your account was successfully updated.'
    else
      render :edit
    end
  end

  def index
    @users = User.search_by_username_bio_skills_title(params[:query])
    @autocomplete_set = User.first.overall_skill_set
  end



  def portfolio
    @own_projects = Project.past.where(user: @user)
    collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @member_projects = Project.past.where(id: collab_ids)
  end

  def portfolio_own_projects
    @own_projects = Project.past.where(user: @user)
    respond_to do |format|
      format.text { render partial: 'user_portfolio_own_projects.html' }
    end
  end

  def portfolio_collabs
    collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @member_projects = Project.past.where(id: collab_ids)
    respond_to do |format|
      format.text { render partial: 'user_portfolio_collabs.html' }
    end
  end




  def ongoing_projects
    @own_projects = Project.upcoming.where(user: @user)
    collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @member_projects = Project.upcoming.where(id: collab_ids)
  end

  def ongoing_own_projects
    @own_projects = Project.upcoming.where(user: @user)
    respond_to do |format|
      format.text { render partial: 'user_ongoing_own_projects.html' }
    end
  end

  def ongoing_collabs
    collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @member_projects = Project.upcoming.where(id: collab_ids)
    respond_to do |format|
      format.text { render partial: 'user_ongoing_collabs.html' }
    end
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
    params.require(:user).permit(:email, :username, :bio, :photo, :website, :instagram, :soundcloud, :youtube, :mixcloud, :linkedin, :twitter, :skills)
  end
end
