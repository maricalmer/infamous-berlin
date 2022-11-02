class DashboardRenderer
  def projects_for(user, status)
    Project.public_send(status).where(user: user).order(created_at: :desc)
  end

  def jobs_for(project_ids, status)
    Job.public_send(status).where(project_id: project_ids).order(created_at: :desc)
  end

  def project_collabs_for(user, status)
    collab_project_ids = Collab.where(member: user).includes([:project]).map { |collab| collab.project.id }
    Project.public_send(status).where(id: collab_project_ids).order(created_at: :desc)
  end

  def received_inquiries_for(job_ids, status)
    Inquiry.public_send(status).where(job_id: job_ids)
  end

  def sent_inquiries_for(user, status)
    Inquiry.public_send(status).where(user: user)
  end

  def display_by_order_of_relevance(ordered_options)
    ordered_options.each do |_k, option|
      return option if option.present?
    end
    return nil
  end
end
