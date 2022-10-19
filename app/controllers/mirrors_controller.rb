class MirrorsController < ApplicationController
  before_action :set_user, only: %i[update ongoing_projects past_projects]
  before_action :set_variant, only: %i[ongoing_projects past_projects]

  require "workflows/mirror_renderer"

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
    @mirrors = MirrorRenderer.new(@user).load_mirrors_for_projects("upcoming")
    authorize @mirrors
    if request.variant == [:mobile]
      render variants: :mobile
    else
      render variants: :desktop
    end
  end

  def past_projects
    @mirrors = MirrorRenderer.new(@user).load_mirrors_for_projects("past")
    authorize @mirrors
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
