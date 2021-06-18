class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_project, only: [:show, :edit, :update, :apply, :unapply]

  def show
    @member = User.find_by(slug: @project.member.first)
    @application = Apply.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      redirect_to dashboard_path, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
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

  private

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
    params.require(:project).permit(:title, :description, :category, :date, :location, :member, photos: [])
  end
end


# modal stays on the page for 1s hitting the apply button and coming back to the show page after chatroom
