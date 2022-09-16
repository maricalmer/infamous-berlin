class MirrorsController < ApplicationController
  before_action :set_user, only: %i[update ongoing_projects past_projects]
  before_action :set_variant, only: %i[ongoing_projects past_projects]

  def update
    @mirror = Mirror.find(params[:id])
    authorize @mirror
    @mirror.update(mirror_params)

    respond_to do |format|
      format.html
      format.text { render partial: "mirrors/mirror_form", locals: { mirror: @mirror, user: @user }, formats: [:html] }
    end
  end

  def ongoing_projects
    @collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @all_projects_ids = Project.upcoming.where(user: @user).or(Project.upcoming.where(id: @collab_ids))
    @mirrors = Mirror.where(project_id: @all_projects_ids).where(user: @user).order(:created_at).includes(%i[user
                                                                                                             project])
    authorize @mirrors
    i = 1
    @mirrors.each do |mirror|
      mirror.update(default_position: i)
      mirror.default_grid_position(i) if mirror.grid_x.nil?
      i += 1
    end
    if request.variant == [:mobile]
      render variants: :mobile
    else
      render variants: :desktop
    end
  end

  def past_projects
    @collab_ids = Collab.where(user_id: @user.id).pluck(:project_id)
    @all_projects_ids = Project.past.where(user: @user).or(Project.past.where(id: @collab_ids))
    @mirrors = Mirror.where(project_id: @all_projects_ids).where(user: @user).order(:created_at).includes(%i[user
                                                                                                             project])
    authorize @mirrors
    i = 1
    @mirrors.each do |mirror|
      mirror.update(default_position: i)
      mirror.default_grid_position(i) if mirror.grid_x.nil?
      i += 1
    end
    if request.variant == [:mobile]
      render variants: :mobile
    else
      render variants: :desktop
    end
  end

  private

  def set_variant
    agent = request.user_agent
    agent =~ /Mobile/ ? request.variant = :mobile : request.variant = :desktop
  end

  def set_user
    @user = User.find_by(slug: params[:user_slug])
  end

  def mirror_params
    params.require(:mirror).permit(:grid_x, :grid_y, :grid_h, :grid_w, :crop_x, :crop_y, :crop_h, :crop_w)
  end
end
