class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show upcoming_projects alternative_masonry]
  before_action :set_project, only: %i[show edit update apply unapply destroy]

  def show
    @members = @project.members
    @jobs = @project.jobs
    @collab = Collab.new

    @autocomplete_set = AutocompleteGenerator.new.usernames
    @project_attachments = @project.attachments.includes([:blob])
  end

  def new
    @project = Project.new
    authorize @project
    @location_autocomplete_set = AutocompleteGenerator.new.location_set
    @category_autocomplete_set = AutocompleteGenerator.new.category_set
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
    @location_autocomplete_set = AutocompleteGenerator.new.location_set
    @category_autocomplete_set = AutocompleteGenerator.new.category_set
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

  def destroy
    @project.destroy
    redirect_to dashboard_path, notice: 'Project deleted'
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
    if params[:search].present? && params[:search][:status] == "past"
      @projects = Project.where(status: "past").includes(user: { photo_attachment: :blob })
    elsif params[:search].present? && params[:search][:status] == "all"
      @projects = Project.all.includes(user: { photo_attachment: :blob })
    else
      @projects = Project.where(status: "upcoming").includes(user: { photo_attachment: :blob })
    end
    @projects = @projects.search_by_title_description_location_category(params[:query]) if params[:query].present?
    authorize @projects
    respond_to do |format|
      format.html
      format.text { render partial: 'search-results.html', locals: { projects: @projects, query: params[:query] } }
    end
  end

  def alternative_masonry
    if params[:search].present? && params[:search][:status] == "past"
      @projects = Project.where(status: "past")
    elsif params[:search].present? && params[:search][:status] == "all"
      @projects = Project.all
    else
      @projects = Project.where(status: "upcoming")
    end
    @projects = @projects.search_by_title_description_location_category(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html
      format.text { render partial: 'search-results.html', locals: { projects: @projects, query: params[:query] } }
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

# modal stays on the page for 1s hitting the apply button and coming back to the show page after chatroom
