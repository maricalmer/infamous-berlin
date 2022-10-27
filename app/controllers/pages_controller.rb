class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home after_registration_path]
  before_action :set_project_ids,
                only: %i[open_jobs_dash close_jobs_dash hold_received_dash accepted_received_dash
                         rejected_received_dash]
  before_action :set_job_ids, only: %i[hold_received_dash accepted_received_dash rejected_received_dash]
  before_action :set_collab_project_ids, only: %i[upcoming_collabs_dash past_collabs_dash]
  before_action :set_search, only: %i[general_search user_search project_search]

  def home
  end

  def dashboard
    # PROJECT MODEL
    @upcoming_projects = Project.upcoming.where(user: current_user).order(created_at: :desc)
    @past_projects = Project.past.where(user: current_user).order(created_at: :desc)
    projects_relevance = { first: @upcoming_projects, second: @past_projects }
    @projects = display_by_relevance_in_dashboard(projects_relevance)
    project_ids = (@upcoming_projects.ids << @past_projects.ids).flatten

    # JOB MODEL
    @open_jobs = Job.open.where(project_id: project_ids).order(created_at: :desc)
    @close_jobs = Job.close.where(project_id: project_ids).order(created_at: :desc)
    jobs_relevance = { first: @open_jobs, second: @close_jobs }
    @jobs = display_by_relevance_in_dashboard(jobs_relevance)
    job_ids = (@open_jobs.ids << @close_jobs.ids).flatten
    # if @open_jobs.any?
    #   @jobs = @open_jobs
    # elsif @close_jobs.any?
    #   @jobs = @close_jobs
    # end


    # COLLAB MODEL
    @collab_project_ids = Collab.where(member: current_user).includes([:project]).map { |collab| collab.project.id }
    @upcoming_collabs = Project.upcoming.where(id: @collab_project_ids).order(created_at: :desc)
    @past_collabs = Project.past.where(id: @collab_project_ids).order(created_at: :desc)
    collabs_relevance = { first: @upcoming_collabs, second: @past_collabs }
    @collabs = display_by_relevance_in_dashboard(collabs_relevance)
    # if @upcoming_collabs.any?
    #   @collabs = @upcoming_collabs
    # elsif @past_collabs.any?
    #   @collabs = @past_collabs
    # end

    # INQUIRY MODEL
    @hold_received_applications = Inquiry.on_hold.where(job_id: job_ids)
    @accepted_received_applications = Inquiry.accepted.where(job_id: job_ids)
    @rejected_received_applications = Inquiry.rejected.where(job_id: job_ids)
    received_inquiries_relevance = { first: @hold_received_applications, second: @accepted_received_applications, third: @rejected_received_applications }
    @received_inquiries = display_by_relevance_in_dashboard(received_inquiries_relevance)
    # @inquiries = display_by_relevance_in_dashboard(inquiries_relevance)
    # if @hold_received_applications.any?
    #   @inquiries = @hold_received_applications
    # elsif @accepted_received_applications.any?
    #   @inquiries = @accepted_received_applications
    # elsif @rejected_received_applications.any?
    #   @inquiries = @rejected_received_applications
    # end

    @hold_sent_applications = Inquiry.on_hold.where(user: current_user)
    @accepted_sent_applications = Inquiry.accepted.where(user: current_user)
    @rejected_sent_applications = Inquiry.rejected.where(user: current_user)
    sent_inquiries_relevance = { first: @hold_sent_applications, second: @accepted_sent_applications, third: @rejected_sent_applications }
    @sent_inquiries = display_by_relevance_in_dashboard(sent_inquiries_relevance)
    # if @hold_sent_applications.any?
    #   @inquiries = @hold_sent_applications
    # elsif @accepted_sent_applications.any?
    #   @inquiries = @accepted_sent_applications
    # elsif @rejected_sent_applications.any?
    #   @inquiries = @rejected_sent_applications
    # end
  end

  def upcoming_projects_dash
    @projects = Project.upcoming.where(user: current_user).order(created_at: :desc)
    respond_to do |format|
      format.text { render partial: 'projects_dash.html' }
      # format.text { render partial: 'projects_dash.html', locals: { projects: @projects } }
    end
  end

  def past_projects_dash
    @projects = Project.past.where(user: current_user).order(created_at: :desc)
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

  def after_registration_path
  end

  private

  def display_by_relevance_in_dashboard(ordered_options)
    ordered_options.each do |_k, option|
      return option if option.present?
    end
    return nil
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
    @collab_project_ids = Collab.where(member: current_user).includes([:project]).map { |collab| collab.project.id }
  end

  def set_search
    @query = params[:query]
    @users = User.search_by_username_bio_skills_title(@query).includes([:photo_attachment])
    @projects = Project.search_by_title_description_location_category(@query).includes([:user])
  end
end
