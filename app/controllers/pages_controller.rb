class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @users = User.all.sort_by(&:id)
    @projects = Project.all.sort_by(&:id)
  end

  def dashboard
    @portfolio_projects = Project.portfolio.where(user: current_user).order(created_at: :desc)
    @upcoming_projects = Project.upcoming.where(user: current_user).order(created_at: :desc)
  end

  def collaboration
    @received_application = Apply.where(applicant_id: current_user.id).order(created_at: :desc)
    projects_ids = Project.where(user: current_user).map(&:id)
    @sent_application = Apply.where(applying_id: projects_ids).order(created_at: :desc)
  end
end
