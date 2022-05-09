class CollabsController < ApplicationController
#   skip_before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_collab, only: [:destroy]
  before_action :find_project, only: [:new, :create]
  after_action :create_mirror, only: [:create]

  # before_action :set_user, only: [:show, :edit, :update]

  def new
    @collab = Collab.new
  end

  def create
    @collab = Collab.new
    @collab.project = @project
    @user = User.find_by(username: params[:project][:member])
    @collab.member = @user
    if @collab.save
      redirect_to project_path(@project)
    else
      @members = @project.members
      @jobs = @project.jobs
      render "projects/show"
    end
  end

  def destroy
    @collab.destroy
    if @collab.user_id == current_user.id
      redirect_to dashboard_path, notice: 'Collaboration deleted'
    else
      @project = Project.find(@collab.project_id)
      redirect_to project_path(@project.slug), notice: 'Members list updated'
    end
  end

  private

  def create_mirror
    mirror = Mirror.create(user: @collab.member, project: @collab.project)
  end

  def find_project
    @project = Project.find_by(slug: params[:project_slug])
  end

  def set_collab
    @collab = Collab.find(params[:id])
  end


  # def collab_params
  #   params.require(:collabs).permit(???)
  # end
end
