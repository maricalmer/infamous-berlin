class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy]
  before_action :set_project, only: %i[new create]

  def index
    # https://gist.github.com/MyklClason/107f277a8da841db39cd566d218c91a5
    # add checkboxes in form and display them on the left side of the page
    # find a way to filter @jobs based on checkbox state
    # add an event on form so that when checkboxes state changes the form is submited via ajax
    @jobs = policy_scope(Job)
    if params[:search].present? && params[:search][:payment] == "fixed_rate"
      @jobs = Job.where(payment: "fixed_rate")
    elsif params[:search].present? && params[:search][:payment] == "hourly_rate"
      @jobs = Job.where(payment: "hourly_rate")
    end
    @autocomplete_set = Job.autocomplete_skills
    @jobs = @jobs.search_by_title_description_skills(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html
      format.text { render partial: 'index_job.html.erb', locals: { jobs: @jobs, query: params[:query] } }
    end
  end

  def show
    @message = Message.new
  end

  def new
    @job = Job.new
    authorize @job
    @location_autocomplete_set = Job.autocomplete_locations
  end

  def create
    @job = Job.new(job_params)
    authorize @job
    @job.project = @project
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
    if @job.save
      redirect_to dashboard_path, notice: 'Job was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @job.destroy
    redirect_to dashboard_path, notice: 'Job was successfully deleted.'
  end

  private

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end

  def set_project
    @project = Project.find_by(slug: params[:project_slug])
  end

  def job_params
    params.require(:job).permit(:title, :description, :location, :money, :payment, :status, :skills_needed)
  end
end
