class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_project, only: [:show, :edit, :update, :apply, :unapply]
  after_action :create_mirror, only: [:create]

  def show
    @members = @project.members
    @jobs = @project.jobs
    @collab = Collab.new
    @autocomplete_set = User.usernames
  end

  def new
    @project = Project.new
    @location_autocomplete_set = Project.first.project_locations
    @category_autocomplete_set = Project.first.project_categories
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    # if params[:project][:photos].any?
    #   params[:project][:photos].each do |photo|
    #     @project.photos.attach(photo)
    #   end
    # end
    @project.update(project_params)
    if @project.save
      redirect_to dashboard_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # def apply
  #   @application = Application.new
  #   @application.user_id = current_user.id
  #   @application.project_id = @project.id
  #   @application.save
  #   @chatroom = Chatroom.new
  #   @chatroom.user_id = current_user.id
  #   @chatroom.project_id = @project.id
  #   @chatroom.save
  #   redirect_to chatroom_path(@chatroom.id), notice: "Say hi to #{@project.user.username} and introduce yourself!"
  # end

  def apply
    if current_user.apply(@project.id)
      @chatroom = create_chatroom
      redirect_to chatroom_path(@chatroom.id), notice: "Say hi to #{@project.user.username} and introduce yourself!"
    end
  end

  def unapply
    if current_user.unapply(@project.id)
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Application deleted" }
        format.js { render action: :apply }
      end
    end
  end

  def upcoming_projects
    @projects = Project.where(status: "upcoming")
    if params[:query].present?
      @projects = Project.where(status: "upcoming").search_by_title_description_location_category(params[:query])
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'search-results.html' }
      # format.text { render partial: 'search-results.html', locals: { projects: @projects }, formats: [:html] }
    end
  end

  private

  def create_mirror
    Mirror.create(user: @project.user, project: @project)
  end

  def create_chatroom
    @chatroom = Chatroom.new
    @chatroom.user_id = current_user.id
    @chatroom.project_id = @project.id
    @chatroom.save
    return @chatroom
  end

  def set_project
    @project = Project.find_by(slug: params[:slug])
  end

  def project_params
    params.require(:project).permit(:title, :description, :category, :date, :location, :status, attachments: [])
  end
end

# modal stays on the page for 1s hitting the apply button and coming back to the show page after chatroom
