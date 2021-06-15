class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_project, only: [ :show, :apply ]

  def show
    @member = User.find_by(slug: @project.member.first)
    @application = Application.new
  end

  def apply
    @application = Application.new
    @application.user_id = current_user.id
    @application.project_id = @project.id
    @application.save
    redirect_to messages_url, notice: 'Introduce yourself'
  end

  def unapply
    if current_user.unapply(@project.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: :apply }
      end
    end
  end

  private

  def set_project
    @project = Project.find_by(slug: params[:slug])
  end

  def article_params
    params.require(:project).permit(:title, :description, :category, :date, :location, :member, photos: [])
  end
end
