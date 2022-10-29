class DashboardRenderer
  def projects_for(user, status)
    Project.public_send(status).where(user: user).order(created_at: :desc)
  end

  def jobs_for(project_ids, status)
    Job.public_send(status).where(project_id: project_ids).order(created_at: :desc)
  end

  def display_by_relevance(ordered_options)
    ordered_options.each do |_k, option|
      return option if option.present?
    end
    return nil
  end

  def project_collabs_for(user, status)
    collab_project_ids = Collab.where(member: user).includes([:project]).map { |collab| collab.project.id }
    Project.public_send(status).where(id: collab_project_ids).order(created_at: :desc)
  end

  private


  # def gather_ids_from(first_collection, second_collection)
  #   (first_collection.ids << second_collection.ids).flatten
  # end
end
