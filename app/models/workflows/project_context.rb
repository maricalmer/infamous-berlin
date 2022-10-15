class ProjectContext
  def upcoming_projects(params)
    if params[:search].present? && params[:search][:status] == "past"
      @projects = Project.where(status: "past").includes(user: { photo_attachment: :blob })
    elsif params[:search].present? && params[:search][:status] == "all"
      @projects = Project.all.includes(user: { photo_attachment: :blob })
    else
      @projects = Project.where(status: "upcoming").includes(user: { photo_attachment: :blob })
    end
    return @projects
  end
end
