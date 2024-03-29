class CollabsController < ApplicationController
  before_action :set_collab, only: [:destroy]
  before_action :find_project, only: %i[new create]

  def new
    @collab = Collab.new
    authorize @collab
  end

  def create
    @collab = Collab.new
    authorize @collab
    @collab.project = @project
    @collab.member = User.find_by(username: params[:project][:member])
    if @collab.save
      redirect_to project_path(@project)
    else
      # finalize build of project shown
      @members = @project.members
      @jobs = @project.jobs
      @project_attachments = @project.attachments.includes([:blob])
      @project_formatted_categories = Services::TagsRenderer.new(@project.category).format_tags
      render "projects/show"
    end
  end

  def destroy
    # collab destroyed by project member owner from his dashboard
    if @collab.user_id == current_user.id
      @collab.destroy
      redirect_to dashboard_path, notice: 'Collaboration deleted'
    # collab destroyed by project owner from project page
    else
      @project = Project.find(@collab.project_id)
      @collab.destroy
      redirect_to project_path(@project.slug), notice: 'Members list updated'
    end
  end

  private

  def find_project
    @project = Project.find_by(slug: params[:project_slug])
  end

  def set_collab
    @collab = Collab.find(params[:id])
    authorize @collab
  end
end
