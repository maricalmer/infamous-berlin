class MirrorsController < ApplicationController
  before_action :set_user, only: [:update, :ongoing_projects, :past_projects]

  def update
    @mirror = Mirror.find(params[:id])
    @mirror.update(mirror_params)

    respond_to do |format|
      format.html
      format.text { render partial: "mirrors/mirror_form", locals: { mirror: @mirror, user: @user }, formats: [:html] }
    end
  end

  def ongoing_projects
    @collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @all_projects_ids = Project.upcoming.where(user: @user).or(Project.upcoming.where(id: @collab_ids))
    @mirrors = Mirror.where(project_id: @all_projects_ids)
    @mirrors.each_with_index do |mirror, index|
      mirror.default_grid_position(index) if mirror.grid_x.nil?
    end
  end

  def past_projects
  end

  private

  def set_user
    @user = User.find_by(slug: params[:user_slug])
  end

  def mirror_params
    params.require(:mirror).permit(:img_key, :grid_x, :grid_y, :grid_h, :grid_w, :crop_x, :crop_y, :crop_h, :crop_w)
  end
end
