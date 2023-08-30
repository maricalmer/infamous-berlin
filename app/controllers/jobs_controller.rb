class JobsController < ApplicationController
  before_action :find_job, only: %i[show edit update destroy]
  before_action :find_project, only: %i[new create]

  def index
    @jobs = policy_scope(Job)
    if params[:search].present? && params[:search][:payment] != "all"
      @jobs = Job.filter_jobs_on(params[:search][:payment])
    end
    @autocomplete_set = Services::AutocompleteGenerator.new.skill_set
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
    @location_autocomplete_set = Services::AutocompleteGenerator.new.location_set
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

  def find_job
    @job = Job.find(params[:id])
    authorize @job
  end

  def find_project
    @project = Project.find_by(slug: params[:project_slug])
  end

  def job_params
    params.require(:job).permit(:title, :description, :location, :money, :payment, :status, :skills_needed)
  end
end
