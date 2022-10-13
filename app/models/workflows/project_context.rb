class ProjectContext
  def upcoming_projects(query)
    if query.present? && query[:status] == "past"
      projects = Project.where(status: "past").includes(user: { photo_attachment: :blob })
    elsif query.present? && query[:status] == "all"
      projects = Project.all.includes(user: { photo_attachment: :blob })
    else
      projects = Project.where(status: "upcoming").includes(user: { photo_attachment: :blob })
    end
    projects = projects.search_by_title_description_location_category(query) if query.present?
    return projects
  end
end
