class DashboardsController < ApplicationController
  before_action :find_different_project_types_instances,
                only: %i[dashboard open_jobs_dash close_jobs_dash hold_received_dash accepted_received_dash rejected_received_dash]
  before_action :find_different_job_types_instances,
                only: %i[dashboard hold_received_dash accepted_received_dash rejected_received_dash]


  def dashboard
    find_different_collab_types_instances
    find_different_received_inquiry_types_instances
    find_different_sent_inquiry_types_instances
  end

  def upcoming_projects_dash
    @projects = Workflows::DashboardRenderer.new.projects_for(current_user, "upcoming")
    render_dashboard_partial_for("projects")
  end

  def past_projects_dash
    @projects = Workflows::DashboardRenderer.new.projects_for(current_user, "past")
    render_dashboard_partial_for("projects")
  end

  def open_jobs_dash
    @jobs = Workflows::DashboardRenderer.new.jobs_for(@project_ids, "open")
    render_dashboard_partial_for("jobs")
  end

  def close_jobs_dash
    @jobs = Workflows::DashboardRenderer.new.jobs_for(@project_ids, "close")
    render_dashboard_partial_for("jobs")
  end

  def upcoming_collabs_dash
    @collabs = Workflows::DashboardRenderer.new.project_collabs_for(current_user, "upcoming")
    render_dashboard_partial_for("collabs")
  end

  def past_collabs_dash
    @collabs = Workflows::DashboardRenderer.new.project_collabs_for(current_user, "past")
    render_dashboard_partial_for("collabs")
  end

  def hold_received_dash
    @inquiries = Workflows::DashboardRenderer.new.received_inquiries_for(@job_ids, "on_hold")
    render_dashboard_partial_for("received")
  end

  def accepted_received_dash
    @inquiries = Workflows::DashboardRenderer.new.received_inquiries_for(@job_ids, "accepted")
    render_dashboard_partial_for("received")
  end

  def rejected_received_dash
    @inquiries = Workflows::DashboardRenderer.new.received_inquiries_for(@job_ids, "rejected")
    render_dashboard_partial_for("received")
  end

  def hold_sent_dash
    @inquiries = Workflows::DashboardRenderer.new.sent_inquiries_for(current_user, "on_hold")
    render_dashboard_partial_for("sent")
  end

  def accepted_sent_dash
    @inquiries = Workflows::DashboardRenderer.new.sent_inquiries_for(current_user, "accepted")
    render_dashboard_partial_for("sent")
  end

  def rejected_sent_dash
    @inquiries = Workflows::DashboardRenderer.new.sent_inquiries_for(current_user, "rejected")
    render_dashboard_partial_for("sent")
  end

  private

  def find_different_project_types_instances
    @upcoming_project = Workflows::DashboardRenderer.new.projects_for(current_user, "upcoming")
    @past_project = Workflows::DashboardRenderer.new.projects_for(current_user, "past")
    @projects = Workflows::DashboardRenderer.new.display_by_order_of_relevance(
      { first: @upcoming_project,
        second: @past_project }
    )
    @project_ids = [@upcoming_project.ids, @past_project.ids].flatten
  end

  def find_different_job_types_instances
    @open_jobs = Workflows::DashboardRenderer.new.jobs_for(@project_ids, "open")
    @close_jobs = Workflows::DashboardRenderer.new.jobs_for(@project_ids, "close")
    @job_ids = [@open_jobs.ids, @close_jobs.ids].flatten
  end

  def find_different_collab_types_instances
    @upcoming_project_collabs = Workflows::DashboardRenderer.new.project_collabs_for(current_user, "upcoming")
    @past_project_collabs = Workflows::DashboardRenderer.new.project_collabs_for(current_user, "past")
    @collabs = Workflows::DashboardRenderer.new.display_by_order_of_relevance(
      { first: @upcoming_project_collabs,
        second: @past_project_collabs }
    )
    @collab_ids = [@upcoming_project_collabs.ids, @past_project_collabs.ids].flatten
  end

  def find_different_received_inquiry_types_instances
    @hold_received_applications = Workflows::DashboardRenderer.new.received_inquiries_for(@job_ids, "on_hold")
    @accepted_received_applications = Workflows::DashboardRenderer.new.received_inquiries_for(@job_ids, "accepted")
    @rejected_received_applications = Workflows::DashboardRenderer.new.received_inquiries_for(@job_ids, "rejected")
    @received_inquiry_ids = [@hold_received_applications.ids, @accepted_received_applications.ids, @rejected_received_applications.ids].flatten
  end

  def find_different_sent_inquiry_types_instances
    @hold_sent_applications = Workflows::DashboardRenderer.new.sent_inquiries_for(current_user, "on_hold")
    @accepted_sent_applications = Workflows::DashboardRenderer.new.sent_inquiries_for(current_user, "accepted")
    @rejected_sent_applications = Workflows::DashboardRenderer.new.sent_inquiries_for(current_user, "rejected")
    @inquiries = Workflows::DashboardRenderer.new.display_by_order_of_relevance(
      { first: @hold_sent_applications,
        second: @accepted_sent_applications,
        third: @rejected_sent_applications }
    )
    @sent_inquiry_ids = [@hold_sent_applications.ids, @accepted_sent_applications.ids, @rejected_sent_applications.ids].flatten
  end

  def render_dashboard_partial_for(partial_type)
    respond_to do |format|
      format.text { render partial: "#{partial_type}_dash.html" }
    end
  end
end
