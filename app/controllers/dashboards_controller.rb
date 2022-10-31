class DashboardsController < ApplicationController
  before_action :set_different_project_types_instances,
                only: %i[dashboard open_jobs_dash close_jobs_dash hold_received_dash accepted_received_dash rejected_received_dash]
  before_action :set_different_job_types_instances,
                only: %i[dashboard hold_received_dash accepted_received_dash rejected_received_dash]

  require "workflows/dashboard_renderer"

  def dashboard
    set_different_collab_types_instances
    set_different_received_inquiry_types_instances
    set_different_sent_inquiry_types_instances
  end

  def upcoming_projects_dash
    @projects = DashboardRenderer.new.projects_for(current_user, "upcoming")
    respond_to do |format|
      format.text { render partial: 'projects_dash.html' }
    end
  end

  def past_projects_dash
    @projects = DashboardRenderer.new.projects_for(current_user, "past")
    respond_to do |format|
      format.text { render partial: 'projects_dash.html' }
    end
  end

  def open_jobs_dash
    @jobs = DashboardRenderer.new.jobs_for(@project_ids, "open")
    respond_to do |format|
      format.text { render partial: 'jobs_dash.html' }
    end
  end

  def close_jobs_dash
    @jobs = DashboardRenderer.new.jobs_for(@project_ids, "close")
    respond_to do |format|
      format.text { render partial: 'jobs_dash.html' }
    end
  end

  def upcoming_collabs_dash
    @collabs = DashboardRenderer.new.project_collabs_for(current_user, "upcoming")
    respond_to do |format|
      format.text { render partial: 'collabs_dash.html' }
    end
  end

  def past_collabs_dash
    @collabs = DashboardRenderer.new.project_collabs_for(current_user, "past")
    respond_to do |format|
      format.text { render partial: 'collabs_dash.html' }
    end
  end

  def hold_received_dash
    @inquiries = DashboardRenderer.new.received_inquiries_for(@job_ids, "on_hold")
    respond_to do |format|
      format.text { render partial: 'received_dash.html' }
    end
  end

  def accepted_received_dash
    @inquiries = DashboardRenderer.new.received_inquiries_for(@job_ids, "accepted")
    respond_to do |format|
      format.text { render partial: 'received_dash.html' }
    end
  end

  def rejected_received_dash
    @inquiries = DashboardRenderer.new.received_inquiries_for(@job_ids, "rejected")
    respond_to do |format|
      format.text { render partial: 'received_dash.html' }
    end
  end

  def hold_sent_dash
    @inquiries = DashboardRenderer.new.sent_inquiries_for(current_user, "on_hold")
    respond_to do |format|
      format.text { render partial: 'sent_dash.html' }
    end
  end

  def accepted_sent_dash
    @inquiries = DashboardRenderer.new.sent_inquiries_for(current_user, "accepted")
    respond_to do |format|
      format.text { render partial: 'sent_dash.html' }
    end
  end

  def rejected_sent_dash
    @inquiries = DashboardRenderer.new.sent_inquiries_for(current_user, "rejected")
    respond_to do |format|
      format.text { render partial: 'sent_dash.html' }
    end
  end

  private

  def set_different_project_types_instances
    @upcoming_project = DashboardRenderer.new.projects_for(current_user, "upcoming")
    @past_project = DashboardRenderer.new.projects_for(current_user, "past")
    @projects = DashboardRenderer.new.display_by_order_of_relevance(
      { first: @upcoming_project,
        second: @past_project }
    )
    @project_ids = [@upcoming_project.ids, @past_project.ids].flatten
  end

  def set_different_job_types_instances
    @open_jobs = DashboardRenderer.new.jobs_for(@project_ids, "open")
    @close_jobs = DashboardRenderer.new.jobs_for(@project_ids, "close")
    @job_ids = [@open_jobs.ids, @close_jobs.ids].flatten
  end

  def set_different_collab_types_instances
    @upcoming_project_collabs = DashboardRenderer.new.project_collabs_for(current_user, "upcoming")
    @past_project_collabs = DashboardRenderer.new.project_collabs_for(current_user, "past")
    @collabs = DashboardRenderer.new.display_by_order_of_relevance(
      { first: @upcoming_project_collabs,
        second: @past_project_collabs }
    )
    @collab_ids = [@upcoming_project_collabs.ids, @past_project_collabs.ids].flatten
  end

  def set_different_received_inquiry_types_instances
    @hold_received_applications = DashboardRenderer.new.received_inquiries_for(@job_ids, "on_hold")
    @accepted_received_applications = DashboardRenderer.new.received_inquiries_for(@job_ids, "accepted")
    @rejected_received_applications = DashboardRenderer.new.received_inquiries_for(@job_ids, "rejected")
    @received_inquiry_ids = [@hold_received_applications.ids, @accepted_received_applications.ids, @rejected_received_applications.ids].flatten
  end

  def set_different_sent_inquiry_types_instances
    @hold_sent_applications = DashboardRenderer.new.sent_inquiries_for(current_user, "on_hold")
    @accepted_sent_applications = DashboardRenderer.new.sent_inquiries_for(current_user, "accepted")
    @rejected_sent_applications = DashboardRenderer.new.sent_inquiries_for(current_user, "rejected")
    @inquiries = DashboardRenderer.new.display_by_order_of_relevance(
      { first: @hold_sent_applications,
        second: @accepted_sent_applications,
        third: @rejected_sent_applications }
    )
    @sent_inquiry_ids = [@hold_sent_applications.ids, @accepted_sent_applications.ids, @rejected_sent_applications.ids].flatten
  end
end
