class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show upcoming_projects]
  before_action :set_project, only: %i[show edit update apply unapply destroy]

  def show
    @members = @project.members
    @jobs = @project.jobs
    @collab = Collab.new
    @project_formatted_categories = Services::TagsRenderer.new(@project.category).format_tags
    @autocomplete_set = Services::AutocompleteGenerator.new.usernames
    @project_attachments = @project.attachments.includes([:blob])
  end

  def new
    @project = Project.new
    authorize @project
    @location_autocomplete_set = Services::AutocompleteGenerator.new.location_set
    @category_autocomplete_set = Services::AutocompleteGenerator.new.category_set
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
    @location_autocomplete_set = Services::AutocompleteGenerator.new.location_set
    @category_autocomplete_set = Services::AutocompleteGenerator.new.category_set
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to dashboard_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to dashboard_path, notice: 'Project deleted'
  end

  def upcoming_projects
    @projects = Project.list_projects_based_on(params)
    @projects = @projects.search_by_title_description_location_category(params[:query]) if params[:query].present?
    authorize @projects
    respond_to do |format|
      format.html
      format.text do
        render partial: 'search-results.html',
               locals: { projects: @projects, query: params[:query], status: params[:search][:status] }
      end
    end
  end

  private

  def create_chatroom
    @chatroom = Chatroom.new
    @chatroom.user_id = current_user.id
    @chatroom.project_id = @project.id
    @chatroom.save
    return @chatroom
  end

  def set_project
    @project = Project.find_by!(slug: params[:slug])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :category, :date, :location, :status, attachments: [])
  end
end
