class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]

  def home
    @users = User.all.sort_by(&:id)
    @projects = Project.all.sort_by(&:id)
  end

  def dashboard
    @portfolio_projects = Project.past.where(user: current_user).order(created_at: :desc)
    @upcoming_projects = Project.upcoming.where(user: current_user).order(created_at: :desc)
  end

  def collaboration
    @received_application = Apply.where(applicant_id: current_user.id).order(created_at: :desc)
    projects_ids = Project.where(user: current_user).map(&:id)
    @sent_application = Apply.where(applying_id: projects_ids).order(created_at: :desc)
  end

  def search
    @users = User.search_by_username_and_bio(params[:query])
    @projects = Project.search_by_title_and_description_and_location(params[:query])
  end
end
