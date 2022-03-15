class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create]

  def index
    @jobs = Job.all
    if params[:query].present?
      @jobs = Job.search_by_title_description_skills(params[:query])
    end
    @autocomplete_set = Job.first.overall_skill_set
  end

  def show
    @message = Message.new
  end

  def new
    @job = Job.new
    @location_autocomplete_set = Job.first.job_locations
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to dashboard_path, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job.update(job_params)
    redirect_to job_path(@job)
  end

  def destroy
    @job.deleted!
    redirect_to dashboard_path, notice: 'Job was successfully deleted.'
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def set_project
    @project = Project.find_by(slug: params[:project_slug])
  end

  def job_params
    params.require(:job).permit(:title, :description, :location, :money, :payment, :status, skills_needed: [])
  end
end
