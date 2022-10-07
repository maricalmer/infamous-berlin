class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_user, only: %i[show edit update destroy]

  def show
    past_projects_ids = Project.past.where(user: @user).pluck(:id)
    past_collabs_ids = Collab.where(user_id: @user.id).includes([:project]).select { |collab| collab.project.past? }.map { |c| c.project_id }
    @portfolio = Project.where(id: past_projects_ids).or(Project.where(id: past_collabs_ids))
    upcoming_projects_ids = Project.upcoming.where(user: @user).pluck(:id)
    upcoming_collabs_ids = Collab.where(user_id: @user.id).select do |collab|
                             collab.project.upcoming?
                           end.map { |c| c.project_id }
    @ongoing_projects = Project.where(id: upcoming_projects_ids).or(Project.where(id: upcoming_collabs_ids))
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
    @users = policy_scope(User)
    @autocomplete_set = User.autocomplete_skills
    @users = User.search_by_username_bio_skills_title(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html
      format.text { render partial: 'index_user.html.erb', locals: { users: @users, query: params[:query] } }
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Account deleted'
  end

  private

  def set_user
    @user = User.find_by!(slug: params[:slug])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:email, :username, :title, :bio, :photo, :website, :instagram, :soundcloud, :youtube,
                                 :mixcloud, :linkedin, :twitter, :skills)
  end
end
