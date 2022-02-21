class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]

  before_action :set_upcoming_projects, only: [:dashboard, :upcoming_projects_dash]
  before_action :set_past_projects, only: [:past_projects_dash, :open_jobs_dash]
  before_action :set_project_ids, only: [:open_jobs_dash, :close_jobs_dash, :hold_received_dash, :accepted_received_dash, :rejected_received_dash]
  before_action :set_job_ids, only: [:hold_received_dash, :accepted_received_dash, :rejected_received_dash]
  before_action :set_collab_project_ids, only: [:upcoming_collabs_dash, :past_collabs_dash]
  before_action :set_search, only: [:general_search, :user_search, :project_search]

  def home
    @users = User.all.sort_by(&:id)
    @projects = Project.all.sort_by(&:id)
  end

  def dashboard
    @past_projects = Project.past.where(user: current_user).order(created_at: :desc)
    project_ids = (@projects.ids << @past_projects.ids).flatten
    # ^^ test with no id in one side or the other
    @past_jobs = Job.close.where(project_id: project_ids).order(created_at: :desc)
    @jobs = Job.open.where(project_id: project_ids).order(created_at: :desc)
    job_ids = (@jobs.ids << @past_jobs.ids).flatten

    @collab_project_ids = Collab.where(member: current_user).map { |collab| collab.project.id }
    @collabs = Project.upcoming.where(id: @collab_project_ids).order(created_at: :desc)
    @past_collabs = Project.past.where(id: @collab_project_ids).order(created_at: :desc)

    @hold_received_applications = Inquiry.on_hold.where(job_id: job_ids)
    @accepted_received_applications = Inquiry.accepted.where(job_id: job_ids)
    @rejected_received_applications = Inquiry.rejected.where(job_id: job_ids)

    @hold_sent_applications = Inquiry.on_hold.where(user: current_user)
    @accepted_sent_applications = Inquiry.accepted.where(user: current_user)
    @rejected_sent_applications = Inquiry.rejected.where(user: current_user)
  end

  def upcoming_projects_dash
    respond_to do |format|
      format.text { render partial: 'projects_dash.html' }
      # format.text { render partial: 'projects_dash.html', locals: { projects: @projects } }
    end
  end

  def past_projects_dash
    respond_to do |format|
      format.text { render partial: 'projects_dash.html' }
      # format.text { render partial: 'projects_dash.html', locals: { projects: @projects } }
    end
  end

  def open_jobs_dash
    @jobs = Job.open.where(project_id: @project_ids).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'jobs_dash.html' }
      # format.text { render partial: 'jobs_dash.html', locals: { jobs: @jobs } }
    end
  end

  def close_jobs_dash
    @jobs = Job.close.where(project_id: @project_ids).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'jobs_dash.html' }
      # format.text { render partial: 'jobs_dash.html', locals: { jobs: @jobs } }
    end
  end

  def hold_received_dash
    @inquiries = Inquiry.on_hold.where(job_id: @jobs).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'received_dash.html' }
      # format.text { render partial: 'received_dash.html', locals: { inquiries: @inquiries } }
    end
  end

  def accepted_received_dash
    @inquiries = Inquiry.accepted.where(job_id: @jobs).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'received_dash.html' }
      # format.text { render partial: 'received_dash.html', locals: { inquiries: @inquiries } }
    end
  end

  def rejected_received_dash
    @inquiries = Inquiry.rejected.where(job_id: @jobs).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'received_dash.html' }
      # format.text { render partial: 'received_dash.html', locals: { inquiries: @inquiries } }
    end
  end

  def upcoming_collabs_dash
    @collabs = Project.upcoming.where(id: @collab_project_ids).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'collabs_dash.html' }
      # format.text { render partial: 'collabs_dash.html', locals: { collabs: @collabs } }
    end
  end

  def past_collabs_dash
    @collabs = Project.past.where(id: @collab_project_ids).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'collabs_dash.html' }
      # format.text { render partial: 'collabs_dash.html', locals: { collabs: @collabs } }
    end
  end

  def hold_sent_dash
    @inquiries = Inquiry.on_hold.where(user_id: current_user.id).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'sent_dash.html' }
      # format.text { render partial: 'sent_dash.html', locals: { inquiries: @inquiries } }
    end
  end

  def accepted_sent_dash
    @inquiries = Inquiry.accepted.where(user_id: current_user.id).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'sent_dash.html' }
      # format.text { render partial: 'sent_dash.html', locals: { inquiries: @inquiries } }
    end
  end

  def rejected_sent_dash
    @inquiries = Inquiry.rejected.where(user_id: current_user.id).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'sent_dash.html' }
      # format.text { render partial: 'sent_dash.html', locals: { inquiries: @inquiries } }
    end
  end

  def general_search
  end

  def user_search
    respond_to do |format|
      format.text { render partial: 'user_search.html' }
    end
  end

  def project_search
    respond_to do |format|
      format.text { render partial: 'project_search.html' }
    end
  end

  private

  def set_upcoming_projects
    @projects = Project.upcoming.where(user: current_user).order(created_at: :desc)
  end

  def set_past_projects
    @projects = Project.past.where(user: current_user).order(created_at: :desc)
  end

  def set_project_ids
    projects = Project.past.where(user: current_user)
    upcoming_projects = Project.upcoming.where(user: current_user)
    @project_ids = (projects.ids << upcoming_projects.ids).flatten
  end

  def set_job_ids
    @jobs = Job.where(project_id: @project_ids).pluck(:id)
  end

  def set_collab_project_ids
    @collab_project_ids = Collab.where(member: current_user).map { |collab| collab.project.id }
  end

  def set_search
    @query = params[:query]
    @users = User.search_by_username_bio_skills_title(@query)
    @projects = Project.search_by_title_description_location_category(@query)
  end
end
