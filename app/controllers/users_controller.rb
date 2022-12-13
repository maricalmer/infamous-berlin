class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index after_registration_path]
  before_action :set_user, only: %i[show edit update destroy]

  def show
    @portfolio = Workflows::UserContext.new(@user).display_portfolio
    @user_formatted_skills = Services::TagsRenderer.new(@user.skills).format_tags
    @ongoing_projects = Workflows::UserContext.new(@user).display_ongoing_projects
    @message = Message.new
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user), notice: 'Your account was successfully updated.'
    else
      render :edit
    end
  end

  def index
    @users = policy_scope(User)
    @autocomplete_set = Services::AutocompleteGenerator.new.skill_set
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

  def after_registration_path
    authorize User
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
